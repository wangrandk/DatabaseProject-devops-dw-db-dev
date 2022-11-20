CREATE TABLE [integration].[QA_ServiceQuality_InterviewDeleted] (
    [Id]                     BIGINT         NOT NULL,
    [SourceFileName]         NVARCHAR (255) NOT NULL,
    [InterviewerId]          BIGINT         NULL,
    [RespondentId]           BIGINT         NOT NULL,
    [Time]                   DATETIME2 (7)  NULL,
    [Age]                    INT            NULL,
    [Gender]                 NVARCHAR (20)  NULL,
    [LineNumber]             INT            NULL,
    [VehicleRef]             INT            NOT NULL,
    [ContractorCode]         NVARCHAR (20)  NULL,
    [GarageCode]             NVARCHAR (20)  NULL,
    [ContractCode]           NVARCHAR (20)  NULL,
    [DurationInMinutes]      INT            NULL,
    [Purpose]                INT            NULL,
    [Frequency]              INT            NULL,
    [Placement]              INT            NULL,
    [Language]               INT            NULL,
    [FromStopPointId]        INT            NULL,
    [InterviewerStartStopId] INT            NULL,
    [InterviewerEndStopId]   INT            NULL,
    [StartLongitude]         DECIMAL (8, 6) NULL,
    [StartLatitude]          DECIMAL (8, 6) NULL,
    [ModifiedAt]             DATETIME2 (7)  NOT NULL,
    [Inserted]               DATETIME2 (0)  NOT NULL,
    [Updated]                DATETIME2 (0)  NOT NULL,
    [Hash]                   VARBINARY (32) NOT NULL,
    CONSTRAINT [PK_QA_ServiceQuality_InterviewDeleted] PRIMARY KEY CLUSTERED ([Id] ASC, [SourceFileName] ASC)
);


GO

