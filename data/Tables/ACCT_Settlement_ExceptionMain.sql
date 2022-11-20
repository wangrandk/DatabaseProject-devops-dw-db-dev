CREATE TABLE [data].[ACCT_Settlement_ExceptionMain] (
    [Id]                 INT             IDENTITY (1, 1) NOT NULL,
    [ExceptionId]        BIGINT          NOT NULL,
    [SequenceNumber]     INT             NOT NULL,
    [FromDateTime]       DATETIME        NOT NULL,
    [ToDateTime]         DATETIME        NOT NULL,
    [SettlementCode]     INT             NOT NULL,
    [SettlementCodeName] NVARCHAR (250)  NOT NULL,
    [RegisteredBy]       NVARCHAR (250)  NOT NULL,
    [RegisteredDateTime] DATETIME        NOT NULL,
    [Status]             NVARCHAR (20)   NOT NULL,
    [Comment]            NVARCHAR (2000) NOT NULL,
    [Updated]            DATETIME        NOT NULL
);


GO

