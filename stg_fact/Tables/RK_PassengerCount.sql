CREATE TABLE [stg_fact].[RK_PassengerCount] (
    [LoadPeriodType]      INT NULL,
    [DateKey]             INT NULL,
    [OperatingDayTypeKey] INT NULL,
    [MunicipalityKey]     INT NULL,
    [RateAreaKey]         INT NULL,
    [LineKey]             INT NULL,
    [ServiceProviderId]   INT NULL,
    [PaxCount]            INT NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [UQ_RK_PartOfTripPassengerCount]
    ON [stg_fact].[RK_PassengerCount]([LoadPeriodType] ASC, [DateKey] ASC, [OperatingDayTypeKey] ASC, [MunicipalityKey] ASC, [RateAreaKey] ASC, [LineKey] ASC, [ServiceProviderId] ASC);


GO

