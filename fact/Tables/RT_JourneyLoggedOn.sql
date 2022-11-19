CREATE TABLE [fact].[RT_JourneyLoggedOn] (
    [JourneyRef]                     CHAR (18)      NOT NULL,
    [OperatingDayDate]               DATE           NOT NULL,
    [PlannedStartDateTime]           TIME (0)       NULL,
    [GarageKey]                      INT            NOT NULL,
    [ContractorKey]                  INT            NULL,
    [LineNumber]                     NUMERIC (4)    NOT NULL,
    [LineDesignation]                VARCHAR (8)    NOT NULL,
    [ContractorCode]                 NVARCHAR (20)  NULL,
    [ContractorGarageCode]           NVARCHAR (20)  NULL,
    [ContractCode]                   NVARCHAR (20)  NULL,
    [JourneyNumber]                  DECIMAL (6)    NOT NULL,
    [PlannedPaidDurationSeconds]     INT            NOT NULL,
    [LoggedOn]                       NUMERIC (2, 1) NULL,
    [PrimaryVehicleNumber]           NUMERIC (5)    NULL,
    [VehicleSourceSystemCode]        NVARCHAR (20)  NULL,
    [PrimaryStaffNumberRegistered]   INT            NOT NULL,
    [PrimaryStaffNumber]             INT            NOT NULL,
    [ProductGroups]                  INT            NOT NULL,
    [PrimaryVehicleNumberRegistered] INT            NOT NULL
);


GO

