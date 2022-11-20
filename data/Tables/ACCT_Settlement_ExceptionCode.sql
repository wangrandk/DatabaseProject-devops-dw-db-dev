CREATE TABLE [data].[ACCT_Settlement_ExceptionCode] (
    [Id]                 INT             IDENTITY (1, 1) NOT NULL,
    [SettlementCode]     INT             NOT NULL,
    [SettlementCodeName] NVARCHAR (100)  NOT NULL,
    [Description]        NVARCHAR (2000) NULL
);


GO

