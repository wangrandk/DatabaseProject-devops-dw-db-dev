CREATE TABLE [integration].[QA_ServiceQuality_ContractorBridge] (
    [SourceSystemCode]     NVARCHAR (20)  NOT NULL,
    [SourceSystemEntryRef] NVARCHAR (250) NOT NULL,
    [ContractorCode]       NVARCHAR (20)  NULL,
    CONSTRAINT [PK_QA_ServiceQuality_ContractorBridge] PRIMARY KEY CLUSTERED ([SourceSystemCode] ASC, [SourceSystemEntryRef] ASC)
);


GO

