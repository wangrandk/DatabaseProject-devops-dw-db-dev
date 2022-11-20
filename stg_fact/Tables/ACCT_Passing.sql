CREATE TABLE [stg_fact].[ACCT_Passing] (
    [DateKey]                   INT           NULL,
    [StopPointKey]              INT           NULL,
    [LineKey]                   INT           NULL,
    [ContractKey]               INT           NULL,
    [ContractorKey]             INT           NULL,
    [GarageKey]                 INT           NULL,
    [TypeKey]                   INT           NULL,
    [JourneyRef]                NVARCHAR (50) NULL,
    [OperatingDayDate]          DATE          NULL,
    [JourneyNumber]             NUMERIC (4)   NULL,
    [SequenceNumber]            INT           NULL,
    [LineNumber]                INT           NULL,
    [StopPointNumber]           INT           NULL,
    [ObservedArrivalDateTime]   DATETIME      NULL,
    [ObservedDepartureDateTime] DATETIME      NULL,
    [ArrivalStateFinal]         INT           NULL,
    [DepartureStateFinal]       INT           NULL,
    [EarliestCheckInTime]       DATETIME      NULL,
    [LatestCheckInTime]         DATETIME      NULL,
    [ContractCode]              NVARCHAR (20) NULL,
    [ContractorCode]            NVARCHAR (20) NULL,
    [GarageCode]                NVARCHAR (50) NULL,
    [TransactionType]           INT           NULL
);


GO

