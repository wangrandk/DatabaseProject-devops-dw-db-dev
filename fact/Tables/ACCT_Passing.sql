CREATE TABLE [fact].[ACCT_Passing] (
    [DateKey]         INT NOT NULL,
    [StopPointKey]    INT NOT NULL,
    [LineKey]         INT NOT NULL,
    [ContractKey]     INT NOT NULL,
    [ContractorKey]   INT NOT NULL,
    [GarageKey]       INT NOT NULL,
    [TransactionType] INT NOT NULL,
    [TypeKey]         INT NOT NULL,
    [NumberOfObs]     INT NULL,
    CONSTRAINT [PK_ACCT_Passing] PRIMARY KEY CLUSTERED ([DateKey] ASC, [StopPointKey] ASC, [LineKey] ASC, [ContractKey] ASC, [ContractorKey] ASC, [GarageKey] ASC, [TransactionType] ASC, [TypeKey] ASC)
);


GO

