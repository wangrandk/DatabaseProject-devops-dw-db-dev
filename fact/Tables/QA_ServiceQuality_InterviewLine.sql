CREATE TABLE [fact].[QA_ServiceQuality_InterviewLine] (
    [SourceSystemCode]     NVARCHAR (10)  NOT NULL,
    [SourceSystemEntryRef] NVARCHAR (100) NOT NULL,
    [InterviewId]          BIGINT         NULL,
    [QuestionKey]          INT            NULL,
    [AnswerKey]            INT            NULL,
    [ModifiedAt]           DATETIME2 (0)  NULL,
    [IsZeroed]             BIT            NULL,
    [IsDeleted]            BIT            NULL,
    [Inserted]             DATETIME2 (0)  NOT NULL,
    [Updated]              DATETIME2 (0)  NOT NULL,
    [Hash]                 VARBINARY (32) NOT NULL,
    CONSTRAINT [PK_QA_ServiceQuality_InterviewLine] PRIMARY KEY CLUSTERED ([SourceSystemCode] ASC, [SourceSystemEntryRef] ASC)
);


GO

