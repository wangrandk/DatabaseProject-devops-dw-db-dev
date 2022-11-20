CREATE TABLE [integration].[QA_ServiceQuality_Quota] (
    [ContractCode]  NVARCHAR (20)  NOT NULL,
    [ContractName]  NVARCHAR (255) NULL,
    [Contractor]    NVARCHAR (255) NULL,
    [TenderCode]    NVARCHAR (255) NULL,
    [ContractUnit]  NVARCHAR (255) NULL,
    [Quota]         INT            NULL,
    [ValidFromDate] DATETIME2 (7)  NOT NULL,
    [ValidToDate]   DATETIME2 (7)  NULL,
    CONSTRAINT [PK_QA_ServiceQuality_Quota] PRIMARY KEY CLUSTERED ([ContractCode] ASC)
);


GO

