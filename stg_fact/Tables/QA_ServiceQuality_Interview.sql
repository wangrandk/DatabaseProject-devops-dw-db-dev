CREATE TABLE [stg_fact].[QA_ServiceQuality_Interview] (
    [SourceSystemCode]        NVARCHAR (10)  NULL,
    [SourceSystemEntryRef]    NVARCHAR (100) NULL,
    [InterviewId]             BIGINT         NULL,
    [SourceFileName]          NVARCHAR (255) NULL,
    [Time]                    DATETIME2 (0)  NULL,
    [DateKey]                 INT            NULL,
    [TimeKey]                 INT            NULL,
    [LineNumber]              INT            NULL,
    [LineNumberFromBridge]    INT            NULL,
    [LineKey]                 INT            NULL,
    [ContractCode]            NVARCHAR (20)  NULL,
    [ContractKey]             INT            NULL,
    [ContractorCode]          NVARCHAR (20)  NULL,
    [ContractorKey]           INT            NULL,
    [VehicleRef]              INT            NULL,
    [VehicleKey]              INT            NULL,
    [GarageCode]              NVARCHAR (20)  NULL,
    [GarageKey]               INT            NULL,
    [FromStopPointId]         INT            NULL,
    [FromStopPointKey]        INT            NULL,
    [InterviewerId]           BIGINT         NULL,
    [InterviewerStartStopId]  INT            NULL,
    [InterviewerStartStopKey] INT            NULL,
    [InterviewerEndStopId]    INT            NULL,
    [InterviewerEndStopKey]   INT            NULL,
    [StartLongitude]          DECIMAL (8, 6) NULL,
    [StartLatitude]           DECIMAL (8, 6) NULL,
    [IsZeroed]                BIT            NULL,
    [IsDeleted]               BIT            NULL,
    [ModifiedAt]              DATETIME2 (0)  NULL,
    [DatedVehicleJourneyId]   BIGINT         NULL,
    [JourneyRef]              NVARCHAR (18)  NULL
);


GO

