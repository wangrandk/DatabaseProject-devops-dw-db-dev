

CREATE procedure [data].[APC_OTS_CountingReport_MatchJourney] (@fromUtc datetime, @toUtc datetime, @force bit = 0)
as
begin
    set nocount on;
    
    if @force = 1
    begin
        update
            [c]
        set
            [BoardingJourneyRef] = null
           ,[AlightingJourneyRef] = null
           ,[BoardingJourneyPointRef] = null
           ,[BoardingJourneyPointMatchType] = null
           ,[AlightingJourneyPointRef] = null
           ,[AlightingJourneyPointMatchType] = null
        from
            [data].[APC_OTS_CountingReport] [c]
        where
            c.[DateTime] between @fromUtc and @toUtc;
    end;

    -- Step 1: Match Boarding JourneyRef using data.RT_VehicleJourneyAssignment
    update
        [c]
    set
        [BoardingJourneyRef] = vja.[JourneyRef]
    from
        [data].[APC_OTS_CountingReport] c
        cross apply (
            select
                [DateTimeLocal] = dateadd(second, c.[Duration] / 2, cast([c].[DateTime] at time zone 'UTC' at time zone 'Central European Standard Time' as datetime2(3)))
        ) calc
        join [data].[RT_VehicleJourneyAssignment] vja on
            vja.[VehicleNumber] = try_cast(c.[VehicleRef] as int)
            and calc.[DateTimeLocal] between vja.[AssignedFromDateTimeExpanded] and vja.[AssignedToDateTime]
            and vja.[SourceSystemCode] = 'PT'
    where
        c.[BoardingJourneyRef] is null
        and c.[DateTime] between @fromUtc and @toUtc;

    -- Step 2: Match Alighting JourneyRef using data.RT_VehicleJourneyAssignment
    update
        [c]
    set
        [AlightingJourneyRef] = vja.[JourneyRef]
    from
        [data].[APC_OTS_CountingReport] c
        cross apply (
            select
                [DateTimeLocal] = dateadd(second, c.[Duration] / 2, cast([c].[DateTime] at time zone 'UTC' at time zone 'Central European Standard Time' as datetime2(3)))
        ) calc
        join [data].[RT_VehicleJourneyAssignment] [vja] on
            vja.[VehicleNumber] = try_cast(c.[VehicleRef] as int)
            and calc.[DateTimeLocal] between vja.[AssignedFromDateTime] and vja.[AssignedToDateTimeExpanded]
            and vja.[SourceSystemCode] = 'PT'
    where
        c.[AlightingJourneyRef] is null
        and c.[DateTime] between @fromUtc and @toUtc;

    -- Stop 3a: Match Boarding JourneyPointRef based on Counting Report should be generated while the bus is dweeling 
    with
    [JourneyPointMatch] as
    (
        select
            c.[CountingReportRef]
           ,p.[JourneyPointRef]
        from
            [data].[APC_OTS_CountingReport] c
            cross apply (
                select
                    [DateTimeLocal] = dateadd(second, c.[Duration] / 2, cast([c].[DateTime] at time zone 'UTC' at time zone 'Central European Standard Time' as datetime2(3)))
            ) calc
            join [data].[RT_JourneyPoint] [p] on
                [p].[JourneyRef] = c.[BoardingJourneyRef]
                and [calc].[DateTimeLocal] between p.[ObservedArrivalDateTime] and [p].[ObservedDepartureDateTime]
                and p.[IsStopPoint] = 1
        where
            c.[BoardingJourneyPointRef] is null
            and c.[DateTime] between @fromUtc and @toUtc
    )
    update
        c
    set
        [BoardingJourneyPointRef] = j.[JourneyPointRef]
       ,[BoardingJourneyPointMatchType] = 1
    from
        [data].[APC_OTS_CountingReport] c
        join [JourneyPointMatch] j on
            j.[CountingReportRef] = c.[CountingReportRef]
    where
        c.[DateTime] between @fromUtc and @toUtc;

    -- Stop 3b: Match Boarding JourneyPointRef based on Counting Report should be clostest to the Observed Departure DateTime
    with
    [JourneyPointMatch] as
    (
        select
            c.[CountingReportRef]
           ,p.[JourneyPointRef]
           ,[Priority] = row_number() over (
                partition by c.[CountingReportRef] 
                order by abs(datediff(second, isnull(p.[ObservedDepartureDateTime], p.[ObservedArrivalDateTime]), [calc].[DateTimeLocal]))
            )
        from
            [data].[APC_OTS_CountingReport] c
            cross apply (
                select
                    [DateTimeLocal] = dateadd(second, c.[Duration] / 2, cast([c].[DateTime] at time zone 'UTC' at time zone 'Central European Standard Time' as datetime2(3)))
            ) calc
            join [data].[RT_JourneyPoint] [p] on
                [p].[JourneyRef] = [c].[BoardingJourneyRef]
                and [calc].[DateTimeLocal] between 
                    dateadd(minute, -30, isnull(p.[ObservedArrivalDateTime], p.[ObservedDepartureDateTime]))
                    and dateadd(minute, 30, isnull(p.[ObservedDepartureDateTime], p.[ObservedArrivalDateTime]))
                and p.[IsStopPoint] = 1
        where
            c.[BoardingJourneyPointRef] is null
            and c.[DateTime] between @fromUtc and @toUtc
    )
    update
        c
    set
        [BoardingJourneyPointRef] = j.[JourneyPointRef]
       ,[BoardingJourneyPointMatchType] = 2
    from
        [data].[APC_OTS_CountingReport] c
        join [JourneyPointMatch] j on
            j.[CountingReportRef] = c.[CountingReportRef]
    where
        c.[DateTime] between @fromUtc and @toUtc
        and j.[Priority] = 1;

    -- Stop 4a: Match Alighting JourneyPointRef based on Counting Report should be generated while the bus is dweeling 
    with
    [JourneyPointMatch] as
    (
        select
            c.[CountingReportRef]
           ,p.[JourneyPointRef]
        from
            [data].[APC_OTS_CountingReport] c
            cross apply (
                select
                    [DateTimeLocal] = dateadd(second, c.[Duration] / 2, cast([c].[DateTime] at time zone 'UTC' at time zone 'Central European Standard Time' as datetime2(3)))
            ) calc
            join [data].[RT_JourneyPoint] [p] on
                [p].[JourneyRef] = c.[AlightingJourneyRef]
                and [calc].[DateTimeLocal] between p.[ObservedArrivalDateTime] and [p].[ObservedDepartureDateTime]
                and p.[IsStopPoint] = 1
        where
            c.[AlightingJourneyPointRef] is null
            and c.[DateTime] between @fromUtc and @toUtc
    )
    update
        c
    set
        [AlightingJourneyPointRef] = j.[JourneyPointRef]
       ,[AlightingJourneyPointMatchType] = 1
    from
        [data].[APC_OTS_CountingReport] c
        join [JourneyPointMatch] j on
            j.[CountingReportRef] = c.[CountingReportRef]
    where
        c.[DateTime] between @fromUtc and @toUtc;

    -- Stop 4b: Match Alighting JourneyPointRef based on Counting Report should be clostest to the Observed Departure DateTime
    with
    [JourneyPointMatch] as
    (
        select
            c.[CountingReportRef]
           ,p.[JourneyPointRef]
           ,[Priority] = row_number() over (
                partition by c.[CountingReportRef] 
                order by abs(datediff(second, isnull(p.[ObservedDepartureDateTime], p.[ObservedArrivalDateTime]), [calc].[DateTimeLocal]))
            )
        from
            [data].[APC_OTS_CountingReport] [c]
            cross apply (
                select
                    [DateTimeLocal] = dateadd(second, c.[Duration] / 2, cast([c].[DateTime] at time zone 'UTC' at time zone 'Central European Standard Time' as datetime2(3)))
            ) calc
            join [data].[RT_JourneyPoint] [p] on
                [p].[JourneyRef] = [c].[AlightingJourneyRef]
                and [calc].[DateTimeLocal] between 
                    dateadd(minute, -30, isnull(p.[ObservedArrivalDateTime], p.[ObservedDepartureDateTime]))
                    and dateadd(minute, 30, isnull(p.[ObservedDepartureDateTime], p.[ObservedArrivalDateTime]))
                and p.[IsStopPoint] = 1
        where
            [c].[AlightingJourneyPointRef] is null
            and [c].[DateTime] between @fromUtc and @toUtc
    )
    update
        [c]
    set
        [AlightingJourneyPointRef] = [j].[JourneyPointRef]
       ,[AlightingJourneyPointMatchType] = 2
    from
        [data].[APC_OTS_CountingReport] [c]
        join [JourneyPointMatch] [j] on
            [j].[CountingReportRef] = [c].[CountingReportRef]
    where
        c.[DateTime] between @fromUtc and @toUtc
        and j.[Priority] = 1;

-- Match garage polygons
    update
        c
    set
        [MatchedLocationContractorRef] = g.[ContractorCode]
       ,[MatchedLocationGarageRef] = g.[GarageCode]
    from
        [data].[APC_OTS_CountingReport] c
        join [data].[GIS_Garage] g on
            g.[Geography].STContains(geography::Point(c.[Latitude], c.[Longitude], 4326)) = 1
    where
        c.[Latitude] is not null
        and c.[Longitude] is not null
    ;

end;

GO

