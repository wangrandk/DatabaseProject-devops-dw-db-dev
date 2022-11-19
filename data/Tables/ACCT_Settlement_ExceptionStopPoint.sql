CREATE TABLE [data].[ACCT_Settlement_ExceptionStopPoint] (
    [Id]             INT    IDENTITY (1, 1) NOT NULL,
    [ExceptionId]    BIGINT NOT NULL,
    [SequenceNumber] INT    NOT NULL,
    [StopId]         BIGINT NOT NULL,
    CONSTRAINT [PK_ACCT_Settlement_ExceptionStopPoint] PRIMARY KEY CLUSTERED ([ExceptionId] ASC, [SequenceNumber] ASC)
);


GO

