CREATE TABLE [dim].[QA_ServiceQuality_ContractPricePerHour] (
    [SourceSystemCode]        NVARCHAR (20)    NOT NULL,
    [SourceSystemEntryRef]    BIGINT           NOT NULL,
    [ContractPricePerHourKey] INT              IDENTITY (1, 1) NOT NULL,
    [PricePerHourPeriod]      NVARCHAR (255)   NOT NULL,
    [ValidFromDateKey]        INT              NOT NULL,
    [ValidToDateKey]          INT              NOT NULL,
    [IsCurrent]               BIT              NOT NULL,
    [ContractCode]            NVARCHAR (20)    NOT NULL,
    [PricePerHour]            NUMERIC (18, 10) NOT NULL,
    [ValidFromDate]           DATE             NOT NULL,
    [ValidToDate]             DATE             NOT NULL,
    CONSTRAINT [PK_QA_ServiceQuality_ContractPricePerHour] PRIMARY KEY CLUSTERED ([ContractPricePerHourKey] ASC, [ContractCode] ASC, [SourceSystemEntryRef] ASC)
);


GO

