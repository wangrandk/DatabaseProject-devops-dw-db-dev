CREATE TABLE [data].[QA_ServiceQuality_Archive] (
    [SourceSystemCode]        NVARCHAR (20)  NOT NULL,
    [SourceSystemEntryId]     NVARCHAR (110) NULL,
    [Filename]                NVARCHAR (100) NOT NULL,
    [FileModifyDateTime]      DATETIME2 (0)  NULL,
    [DataSupplier]            NVARCHAR (30)  NOT NULL,
    [InterviewerId]           NVARCHAR (255) NULL,
    [InterviewDateTime]       DATETIME2 (0)  NULL,
    [Line]                    NVARCHAR (255) NULL,
    [ContractorName]          NVARCHAR (255) NULL,
    [BusNo]                   NVARCHAR (255) NULL,
    [InterviewId]             NVARCHAR (255) NULL,
    [StartStopNo]             NVARCHAR (255) NULL,
    [EndStopNo]               NVARCHAR (255) NULL,
    [RespondentId]            NVARCHAR (255) NULL,
    [QuestionText]            NVARCHAR (255) NULL,
    [AnswerValue]             NVARCHAR (255) NULL,
    [InterviewStartLatitude]  NVARCHAR (255) NULL,
    [InterviewStartLongitude] NVARCHAR (255) NULL,
    [InterviewTypeId]         NVARCHAR (255) NULL
);


GO

