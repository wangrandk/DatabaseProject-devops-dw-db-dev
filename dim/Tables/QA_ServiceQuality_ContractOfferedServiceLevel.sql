CREATE TABLE [dim].[QA_ServiceQuality_ContractOfferedServiceLevel] (
    [ContractOfferedServiceLevelKey] INT            IDENTITY (1, 1) NOT NULL,
    [OfferedServiceLevel]            DECIMAL (9, 2) NULL,
    [ContractCode]                   NVARCHAR (20)  NOT NULL,
    [SourceSystemCode]               NVARCHAR (20)  NOT NULL,
    [SourceSystemEntryId]            BIGINT         NOT NULL,
    CONSTRAINT [PK_QA_ServiceQuality_ContractOfferedServiceLevel] PRIMARY KEY CLUSTERED ([ContractOfferedServiceLevelKey] ASC)
);


GO

