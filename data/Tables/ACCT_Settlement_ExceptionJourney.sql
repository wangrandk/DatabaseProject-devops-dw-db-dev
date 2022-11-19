CREATE TABLE [data].[ACCT_Settlement_ExceptionJourney] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [ExceptionId]    BIGINT        NOT NULL,
    [SequenceNumber] INT           NOT NULL,
    [JourneyRef]     NVARCHAR (18) NOT NULL,
    CONSTRAINT [PK_ACCT_Settlement_ExceptionJourney] PRIMARY KEY CLUSTERED ([ExceptionId] ASC, [SequenceNumber] ASC)
);


GO

