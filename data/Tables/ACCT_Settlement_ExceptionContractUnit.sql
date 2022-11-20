CREATE TABLE [data].[ACCT_Settlement_ExceptionContractUnit] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [ExceptionId]    BIGINT         NOT NULL,
    [SequenceNumber] INT            NOT NULL,
    [ContractUnit]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_ACCT_Settlement_ExceptionContractUnit] PRIMARY KEY CLUSTERED ([ExceptionId] ASC, [SequenceNumber] ASC, [ContractUnit] ASC)
);


GO

