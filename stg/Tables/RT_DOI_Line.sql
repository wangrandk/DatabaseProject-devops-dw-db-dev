CREATE TABLE [stg].[RT_DOI_Line] (
    [LineId]                   DECIMAL (16)  NULL,
    [LineGid]                  DECIMAL (16)  NULL,
    [LineNumber]               DECIMAL (4)   NULL,
    [LineName]                 NVARCHAR (50) NULL,
    [LineDesignation]          NVARCHAR (8)  NULL,
    [LineIsMonitored]          BIT           NULL,
    [DefaultTransportModeCode] VARCHAR (8)   NULL,
    [TransportAuthorityCode]   NVARCHAR (20) NULL,
    [ValidFromDate]            DATE          NULL,
    [ValidToDate]              DATE          NULL,
    [LastModifiedUtcDateTime]  DATETIME2 (3) NULL
);


GO

