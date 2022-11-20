CREATE TABLE [data].[QA_ServiceQuality_Quota] (
    [ContractCode]  NVARCHAR (20)  NOT NULL,
    [ContractName]  NVARCHAR (255) NULL,
    [Contractor]    NVARCHAR (255) NULL,
    [TenderCode]    NVARCHAR (255) NULL,
    [ContractUnit]  NVARCHAR (255) NULL,
    [Quota]         INT            NULL,
    [ValidFromDate] DATETIME2 (7)  NOT NULL,
    [ValidToDate]   DATETIME2 (7)  NULL,
    CONSTRAINT [pk_QA_ServiceQuality_Quota] PRIMARY KEY CLUSTERED ([ContractCode] ASC, [ValidFromDate] ASC)
);


GO

