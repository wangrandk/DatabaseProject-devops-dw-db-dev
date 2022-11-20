CREATE TABLE [fact].[QA_ServiceQuality_Interview] (
    [SourceSystemCode]        NVARCHAR (10)  NOT NULL,
    [SourceSystemEntryRef]    NVARCHAR (100) NOT NULL,
    [SourceFileName]          NVARCHAR (255) NULL,
    [InterviewId]             BIGINT         NULL,
    [JourneyRef]              NVARCHAR (18)  NULL,
    [DateKey]                 INT            NULL,
    [TimeKey]                 INT            NULL,
    [LineKey]                 INT            NULL,
    [ContractKey]             INT            NULL,
    [ContractorKey]           INT            NULL,
    [VehicleKey]              INT            NULL,
    [GarageKey]               INT            NULL,
    [FromStopPointKey]        INT            NULL,
    [InterviewerId]           BIGINT         NULL,
    [InterviewerStartStopKey] INT            NULL,
    [InterviewerEndStopKey]   INT            NULL,
    [StartLongitude]          DECIMAL (8, 6) NULL,
    [StartLatitude]           DECIMAL (8, 6) NULL,
    [IsZeroed]                BIT            NULL,
    [IsDeleted]               BIT            NULL,
    [ModifiedAt]              DATETIME2 (0)  NULL,
    [Inserted]                DATETIME2 (0)  NOT NULL,
    [Updated]                 DATETIME2 (0)  NOT NULL,
    [Hash]                    VARBINARY (32) NOT NULL,
    CONSTRAINT [PK_QA_ServiceQuality_Interview] PRIMARY KEY CLUSTERED ([SourceSystemCode] ASC, [SourceSystemEntryRef] ASC)
);


GO

