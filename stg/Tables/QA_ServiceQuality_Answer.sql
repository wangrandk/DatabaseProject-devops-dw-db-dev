CREATE TABLE [stg].[QA_ServiceQuality_Answer] (
    [FileId]                  INT            NULL,
    [SourceSystemCode]        NVARCHAR (20)  NOT NULL,
    [SourceSystemEntryId]     NVARCHAR (255) NULL,
    [InterviewerId]           NVARCHAR (255) NULL,
    [datetime2]               DATETIME2 (7)  NULL,
    [Line]                    NVARCHAR (255) NULL,
    [ContractorName]          NVARCHAR (255) NULL,
    [BusNo]                   NVARCHAR (255) NULL,
    [InterviewId]             NVARCHAR (255) NULL,
    [StartStopNo]             NVARCHAR (255) NULL,
    [EndStopNo]               NVARCHAR (255) NULL,
    [RespondentId]            NVARCHAR (255) NULL,
    [QuestionText]            NVARCHAR (255) NULL,
    [AnswerValue]             NVARCHAR (255) NULL,
    [ValidFlag]               BIT            NULL,
    [DataQualityType]         SMALLINT       NULL,
    [InterviewTypeId]         NVARCHAR (255) NULL,
    [InterviewStartLatitude]  NVARCHAR (255) NULL,
    [InterviewStartLongitude] NVARCHAR (255) NULL,
    [FileModifyDateTime]      DATETIME2 (0)  NULL
);


GO

