CREATE TABLE [stg_dim].[QA_ServiceQuality_ContractPricePerHour] (
    [ContractCode]            NVARCHAR (20)    NULL,
    [SourceSystemCode]        NVARCHAR (20)    NOT NULL,
    [SourceSystemEntryRef]    BIGINT           NULL,
    [ContractPricePerHourKey] INT              NULL,
    [PricePerHourPeriod]      NVARCHAR (255)   NULL,
    [PricePerHour]            NUMERIC (18, 10) NULL,
    [ValidFromDate]           DATE             NULL,
    [ValidToDate]             DATE             NULL,
    [ValidFromDateKey]        INT              NULL,
    [ValidToDateKey]          INT              NULL,
    [IsCurrent]               BIT              NULL
);


GO

