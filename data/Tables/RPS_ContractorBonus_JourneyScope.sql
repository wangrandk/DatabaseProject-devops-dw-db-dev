CREATE TABLE [data].[RPS_ContractorBonus_JourneyScope] (
    [ContractorCode]          NVARCHAR (20)  NOT NULL,
    [ContractCode]            NVARCHAR (20)  NOT NULL,
    [GarageCode]              NVARCHAR (20)  NOT NULL,
    [ValidFromDate]           DATE           NOT NULL,
    [ValidToDate]             DATE           NULL,
    [RateAreaCombinationCode] NVARCHAR (20)  NULL,
    [EmailAddress]            NVARCHAR (255) NULL,
    [Note]                    NVARCHAR (255) NULL,
    CONSTRAINT [PK_RPS_ContractorBonus_JourneyScope] PRIMARY KEY CLUSTERED ([ContractorCode] ASC, [ContractCode] ASC, [GarageCode] ASC, [ValidFromDate] ASC)
);


GO

EXECUTE sp_addextendedproperty @name = N'sys_sensitivity_label_name', @value = N'Confidential - GDPR', @level0type = N'SCHEMA', @level0name = N'data', @level1type = N'TABLE', @level1name = N'RPS_ContractorBonus_JourneyScope', @level2type = N'COLUMN', @level2name = N'EmailAddress';


GO

EXECUTE sp_addextendedproperty @name = N'sys_information_type_name', @value = N'Contact Info', @level0type = N'SCHEMA', @level0name = N'data', @level1type = N'TABLE', @level1name = N'RPS_ContractorBonus_JourneyScope', @level2type = N'COLUMN', @level2name = N'EmailAddress';


GO

EXECUTE sp_addextendedproperty @name = N'sys_information_type_id', @value = N'5C503E21-22C6-81FA-620B-F369B8EC38D1', @level0type = N'SCHEMA', @level0name = N'data', @level1type = N'TABLE', @level1name = N'RPS_ContractorBonus_JourneyScope', @level2type = N'COLUMN', @level2name = N'EmailAddress';


GO

EXECUTE sp_addextendedproperty @name = N'sys_sensitivity_label_id', @value = N'989ADC05-3F3F-0588-A635-F475B994915B', @level0type = N'SCHEMA', @level0name = N'data', @level1type = N'TABLE', @level1name = N'RPS_ContractorBonus_JourneyScope', @level2type = N'COLUMN', @level2name = N'EmailAddress';


GO

