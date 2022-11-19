CREATE TABLE [stg_fact].[QA_ServiceQuality_InterviewLine] (
    [SourceSystemCode]     NVARCHAR (10)  NULL,
    [SourceSystemEntryRef] NVARCHAR (100) NULL,
    [InterviewId]          BIGINT         NULL,
    [RespondentId]         BIGINT         NULL,
    [QuestionTypeId]       BIGINT         NULL,
    [QuestionId]           BIGINT         NULL,
    [QuestionKey]          INT            NULL,
    [AnswerKey]            INT            NULL,
    [AnswerValue]          BIGINT         NULL,
    [ModifiedAt]           DATETIME2 (0)  NULL,
    [IsZeroed]             BIT            NULL,
    [IsDeleted]            BIT            NULL
);


GO

