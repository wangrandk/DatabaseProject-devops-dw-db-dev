CREATE TABLE [fact].[QA_ServiceQuality_ServiceLevel] (
    [DateKey]                  INT              NOT NULL,
    [ContractorKey]            INT              NOT NULL,
    [ContractKey]              INT              NOT NULL,
    [LineKey]                  INT              NOT NULL,
    [JourneyRef]               CHAR (18)        NOT NULL,
    [PaidDurationSeconds]      NUMERIC (18, 10) NOT NULL,
    [CancelledDurationSeconds] NUMERIC (18, 10) NULL,
    [PricePerHour]             NUMERIC (18, 10) NULL,
    [Locked]                   BIT              NULL,
    [LockedTimeStamp]          DATETIME2 (7)    NULL,
    [UpdatedTimeStamp]         DATETIME2 (7)    NULL,
    [OfferedServiceLevel]      DECIMAL (9, 2)   NULL,
    [IsFuture]                 BIT              NULL,
    [LineDisplayName]          NVARCHAR (250)   NULL,
    [ContractName]             NVARCHAR (250)   NULL,
    [MeasuringPeriodKey]       INT              NULL,
    CONSTRAINT [BK_QA_ServiceQuality_ServiceLevel] PRIMARY KEY CLUSTERED ([JourneyRef] ASC)
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [UQ_QA_ServiceQuality_ServiceLevel_Update]
    ON [fact].[QA_ServiceQuality_ServiceLevel]([DateKey] ASC, [ContractKey] ASC, [JourneyRef] ASC);


GO

CREATE COLUMNSTORE INDEX [CSIX_QA_ServiceQuality_ServiceLevel]
    ON [fact].[QA_ServiceQuality_ServiceLevel]([DateKey], [MeasuringPeriodKey], [ContractorKey], [ContractKey], [LineKey], [IsFuture], [LineDisplayName], [ContractName]);


GO

