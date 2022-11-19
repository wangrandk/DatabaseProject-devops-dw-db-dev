CREATE TABLE [integration].[QA_ServiceQuality_InterviewLineDeleted] (
    [InterviewId]        BIGINT         NOT NULL,
    [RespondentId]       BIGINT         NOT NULL,
    [QuestionId]         BIGINT         NOT NULL,
    [SurveyQuestionType] BIGINT         NULL,
    [AnswerValue]        BIGINT         NOT NULL,
    [ModifiedAt]         DATETIME2 (7)  NOT NULL,
    [IsZeroed]           INT            NULL,
    [Inserted]           DATETIME2 (0)  NOT NULL,
    [Updated]            DATETIME2 (0)  NOT NULL,
    [Hash]               VARBINARY (32) NOT NULL,
    CONSTRAINT [PK_QA_ServiceQuality_InterviewQuestionDeleted] PRIMARY KEY CLUSTERED ([InterviewId] ASC, [QuestionId] ASC)
);


GO

