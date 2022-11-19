CREATE TABLE [stg].[APC_OTS_CountingReport] (
    [CountingReportRef]              NVARCHAR (50)  NULL,
    [ReceivedDateTime]               DATETIME2 (3)  NULL,
    [DateTime]                       DATETIME2 (3)  NULL,
    [VehicleRef]                     NVARCHAR (32)  NULL,
    [VehicleIdentificationNumber]    NVARCHAR (100) NULL,
    [SequenceNumber]                 BIGINT         NULL,
    [Duration]                       INT            NULL,
    [Latitude]                       FLOAT (53)     NULL,
    [Longitude]                      FLOAT (53)     NULL,
    [Bearing]                        FLOAT (53)     NULL,
    [GpsHdop]                        FLOAT (53)     NULL,
    [CountingAccuracy]               FLOAT (53)     NULL,
    [BoardingCount]                  INT            NULL,
    [AlightingCount]                 INT            NULL,
    [DoorReports]                    NVARCHAR (MAX) NULL,
    [BoardingJourneyRef]             CHAR (18)      NULL,
    [BoardingJourneyPointRef]        CHAR (22)      NULL,
    [BoardingJourneyPointMatchType]  TINYINT        NULL,
    [AlightingJourneyRef]            CHAR (18)      NULL,
    [AlightingJourneyPointRef]       CHAR (22)      NULL,
    [AlightingJourneyPointMatchType] TINYINT        NULL,
    [MatchedLocationContractorRef]   NVARCHAR (32)  NULL,
    [MatchedLocationGarageRef]       NVARCHAR (32)  NULL
);


GO

