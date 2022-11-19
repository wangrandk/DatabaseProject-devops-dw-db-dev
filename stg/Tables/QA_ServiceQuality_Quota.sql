CREATE TABLE [stg].[QA_ServiceQuality_Quota] (
    [ContractCode]  NVARCHAR (20)  NULL,
    [ContractName]  NVARCHAR (255) NULL,
    [Contractor]    NVARCHAR (255) NULL,
    [TenderCode]    NVARCHAR (255) NULL,
    [ContractUnit]  NVARCHAR (255) NULL,
    [Quota]         INT            NULL,
    [ValidFromDate] DATETIME2 (7)  NULL,
    [ValidToDate]   DATETIME2 (7)  NULL
);


GO

