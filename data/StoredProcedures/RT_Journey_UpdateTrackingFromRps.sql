


-- =============================================
-- Author:      Niklas Christoffer Petersen
-- Create Date: 2022-25-14
-- Description: Updates RT_Journey with RPS-matching data.
-- Parameters:  @date : The UTC date to update matching for. The 
-- =============================================
CREATE PROCEDURE [data].[RT_Journey_UpdateTrackingFromRps]
(
    @date DATE
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    set nocount on;

    /* Step 1: Update with manual assignments, i.e. RPS_Matching_VehicleJourneyAssignment. */
    with
    [ManualAssignment] as 
    (
        select
            vja.[JourneyRef],
            vja.[VehicleId],
            vja.[DeviceId],
            [TotalReportCount] = sum(vja.[TotalPositionCount]),
            [FaultyReportCount] = sum(vja.[NoGpsFixCount] + vja.[LowGpsQualityCount] + vja.[RepeatedPositionCount]),    
            [ObservedCoverageSeconds] = sum(vja.[ObservedCoverageSeconds]),
            [ObservedCoverage] = CASE WHEN 	   sum(vja.[ObservedCoverageSeconds]) = 0 THEN 		  SUM(vja.[ObservedCoverage])/COUNT(1)
			ELSE                
			SUM(vja.[ObservedCoverageSeconds] * vja.[ObservedCoverage]) / sum(vja.[ObservedCoverageSeconds])
			END, 
            [Rank] = row_number() over (partition by vja.[JourneyRef] order by sum(vja.[ObservedCoverageSeconds]) desc)
        FROM
            [data].[RPS_Matching_VehicleJourneyAssignment] vja
        where
            vja.[JourneyRef] is not null
            and vja.[FromDateTimeUtc] < DATEADD(day, 1, @date) 
            and @date <= vja.[ToDateTimeUtc]
        group by
            vja.[JourneyRef],
            vja.[VehicleId],
            vja.[DeviceId]
    )
    update
        j
    set
        [PrimaryVehicleAssignmentType] = 1,
        [TrackingSourceSystemCode] = 'RPS',
        [PrimaryTrackingTotalReportCount] = ma.[TotalReportCount],
        [PrimaryTrackingFaultyReportCount] = ma.[FaultyReportCount],
        [PrimaryTrackingObservedCoverage] = ma.[ObservedCoverage],
        [PrimaryTrackingObservedCoverageSeconds] = ma.[ObservedCoverageSeconds]
    from
        [ManualAssignment] ma
        join [data].[RT_Journey] j on j.[JourneyRef] = ma.[JourneyRef]
    where
        ma.[Rank] = 1 
        -- This handles rare cases where multiple assignements exists just around midnight.
        -- We will try to maximize this in favour of the operator.
        and ma.[ObservedCoverage] >= isnull(j.[PrimaryTrackingObservedCoverage], 0);

    /* Step 2: Automatic Assignment */
    WITH
    [UntrackedJourney] AS 
    (
        SELECT
            j.[JourneyRef]
           ,[VehicleId] = CAST(vja.[VehicleNumber] AS NVARCHAR(255))
           ,calc.[AssignedFromUtc]
           ,calc.[AssignedToUtc]
        FROM
            [data].[RT_Journey] j
            JOIN data.[RT_VehicleJourneyAssignment] vja ON
                vja.[JourneyRef] = j.[JourneyRef]
                AND vja.[SourceSystemCode] = 'PT'
            CROSS APPLY (
                SELECT
                    [AssignedFromUtc] = CAST(vja.[AssignedFromDateTime] AT TIME ZONE 'Central European Standard Time' AT TIME ZONE 'UTC' AS DATETIME2(3))
                   ,[AssignedToUtc] = CAST(vja.[AssignedToDateTime] AT TIME ZONE 'Central European Standard Time' AT TIME ZONE 'UTC' AS DATETIME2(3))
            ) calc
        WHERE
            j.[OperatingDayDate] BETWEEN DATEADD(DAY, -1, @date) AND DATEADD(DAY, 1, @date)
            AND @date <= calc.[AssignedToUtc]
            AND calc.[AssignedFromUtc] < DATEADD(DAY, 1, @date)
            AND j.[TrackingSourceSystemCode] IS NULL
    ),
    [PositionQuality] AS
    (
        SELECT
            vja.[JourneyRef],
            [VehicleId] = TRY_CAST(p.[VehicleId] AS INT),
            p.[UnitIdentity],
            p.[SendDateTime],
            [NoGpsFix] = CASE WHEN p.[GpsFixType] = 0 THEN 1 ELSE 0 END,
            [LowGpsQuality] = CASE WHEN p.[GpsQuality] = 15 THEN 1 ELSE 0 END,
            [RepeatedPosition] = CASE
                /* Position is counted as invalid, speed indicate movement, but lat/lng is not updated */
                WHEN [Latitude] = LAG(p.[Latitude]) OVER (PARTITION BY p.[VehicleId], p.[UnitIdentity] ORDER BY p.[SendDateTime])
                    AND [Longitude] = LAG(p.[Longitude]) OVER (PARTITION BY p.[VehicleId], p.[UnitIdentity] ORDER BY p.[SendDateTime])
                    AND [Speed] > 5 
                    AND LAG([Speed]) OVER (PARTITION BY p.[VehicleId], p.[UnitIdentity] ORDER BY p.[SendDateTime]) > 5 THEN 1
                ELSE 0 
            END,
            [RegularCoverageMs] =
            CASE
                WHEN DATEDIFF(MILLISECOND, LAG(p.[SendDateTime]) OVER (PARTITION BY p.[VehicleId], p.[UnitIdentity] ORDER BY p.[SendDateTime]), [SendDateTime]) <= 2000
                    THEN DATEDIFF(MILLISECOND, LAG(p.[SendDateTime]) OVER (PARTITION BY p.[VehicleId], p.[UnitIdentity] ORDER BY p.[SendDateTime]), [SendDateTime])
            END
        FROM
            [UntrackedJourney] vja
            JOIN [data].[RPS_PositionMessage] p (NOLOCK) ON p.[VehicleId] = vja.[VehicleId] AND 
            p.[SendDateTime] BETWEEN vja.[AssignedFromUtc] AND vja.[AssignedToUtc]
    ),
    [JourneyTracking] AS 
    (
        SELECT
            p.[JourneyRef],
            p.[VehicleId],
            p.[UnitIdentity],
            [FromDateTimeUtc] = MIN(p.[SendDateTime]),
            [ToDateTimeUtc] = MAX(p.[SendDateTime]),
            [FaultyReportCount] = SUM(p.[NoGpsFix] + p.[LowGpsQuality] + p.[RepeatedPosition]),   
            [TotalReportCount] = COUNT(p.[VehicleId]),       
            [ObservedCoverageSeconds] = SUM(p.[RegularCoverageMs]) / 1000,
            [ObservedCoverage] =
            CASE
                WHEN DATEDIFF(SECOND, MIN(p.[SendDateTime]), MAX(p.[SendDateTime])) < SUM([RegularCoverageMs]) / 1000.0 THEN 1
                WHEN DATEDIFF(SECOND, MIN(p.[SendDateTime]), MAX(p.[SendDateTime])) = 0 THEN 0
                ELSE SUM([RegularCoverageMs]) / 1000.0 / DATEDIFF(SECOND, MIN(p.[SendDateTime]), MAX(p.[SendDateTime]))
            END,
            [Rank] = ROW_NUMBER() OVER (PARTITION BY p.[JourneyRef] ORDER BY SUM(p.[RegularCoverageMs]) DESC)
        FROM
            [PositionQuality] p
        GROUP BY
            p.[JourneyRef],
            p.[VehicleId],
            p.[UnitIdentity]
        HAVING
            MIN(p.[SendDateTime]) < MAX(p.[SendDateTime])
    )
    UPDATE
        j
    SET
        [PrimaryVehicleAssignmentType] = 2,
        [TrackingSourceSystemCode] = 'RPS',
        [PrimaryTrackingTotalReportCount] = jt.[TotalReportCount],
        [PrimaryTrackingFaultyReportCount] = jt.[FaultyReportCount],
        [PrimaryTrackingObservedCoverage] = jt.[ObservedCoverage],
        [PrimaryTrackingObservedCoverageSeconds] = jt.[ObservedCoverageSeconds]
    FROM
        [JourneyTracking] jt
        JOIN [data].[RT_Journey] j ON j.[JourneyRef] = jt.[JourneyRef]
    WHERE
        jt.[Rank] = 1 
        -- This handles rare cases where multiple assignements exists just around midnight.
        -- We will try to maximize this in favour of the operator.
        AND jt.[ObservedCoverage] >= ISNULL(j.[PrimaryTrackingObservedCoverage], 0)

END

GO

