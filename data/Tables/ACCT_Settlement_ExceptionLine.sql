CREATE TABLE [data].[ACCT_Settlement_ExceptionLine] (
    [Id]             INT    IDENTITY (1, 1) NOT NULL,
    [ExceptionId]    BIGINT NOT NULL,
    [SequenceNumber] INT    NOT NULL,
    [Line]           BIGINT NOT NULL,
    [LineDirection]  INT    NOT NULL,
    CONSTRAINT [PK_ACCT_Settlement_ExceptionLine] PRIMARY KEY CLUSTERED ([ExceptionId] ASC, [SequenceNumber] ASC)
);


GO

