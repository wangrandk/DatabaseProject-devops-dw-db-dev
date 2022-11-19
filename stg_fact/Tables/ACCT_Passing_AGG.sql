CREATE TABLE [stg_fact].[ACCT_Passing_AGG] (
    [DateKey]         INT           NOT NULL,
    [StopPointKey]    INT           NOT NULL,
    [LineKey]         INT           NOT NULL,
    [ContractKey]     INT           NOT NULL,
    [ContractorKey]   INT           NOT NULL,
    [GarageKey]       INT           NOT NULL,
    [TypeKey]         INT           NOT NULL,
    [Journeyref]      NVARCHAR (25) NULL,
    [TransactionType] INT           NOT NULL,
    [NumberOfObs]     INT           NULL
);


GO

