CREATE TABLE [integration].[RK_Ticket_SalesReportStatus] (
    [Id]               INT             IDENTITY (1, 1) NOT NULL,
    [ReportDate]       DATE            NOT NULL,
    [CustomerCode]     NVARCHAR (20)   NOT NULL,
    [CustomerName]     NVARCHAR (250)  NOT NULL,
    [CustomerEmail]    NVARCHAR (250)  NULL,
    [Status]           INT             NOT NULL,
    [ErrorMessage]     NVARCHAR (2000) NULL,
    [ReportRenderTime] INT             NULL,
    [MailSendTime]     INT             NULL,
    CONSTRAINT [PK_RK_Ticket_SalesReportStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO

EXECUTE sp_addextendedproperty @name = N'sys_sensitivity_label_name', @value = N'Confidential - GDPR', @level0type = N'SCHEMA', @level0name = N'integration', @level1type = N'TABLE', @level1name = N'RK_Ticket_SalesReportStatus', @level2type = N'COLUMN', @level2name = N'CustomerEmail';


GO

EXECUTE sp_addextendedproperty @name = N'sys_information_type_name', @value = N'Contact Info', @level0type = N'SCHEMA', @level0name = N'integration', @level1type = N'TABLE', @level1name = N'RK_Ticket_SalesReportStatus', @level2type = N'COLUMN', @level2name = N'CustomerEmail';


GO

EXECUTE sp_addextendedproperty @name = N'sys_information_type_id', @value = N'5C503E21-22C6-81FA-620B-F369B8EC38D1', @level0type = N'SCHEMA', @level0name = N'integration', @level1type = N'TABLE', @level1name = N'RK_Ticket_SalesReportStatus', @level2type = N'COLUMN', @level2name = N'CustomerEmail';


GO

EXECUTE sp_addextendedproperty @name = N'sys_sensitivity_label_id', @value = N'989ADC05-3F3F-0588-A635-F475B994915B', @level0type = N'SCHEMA', @level0name = N'integration', @level1type = N'TABLE', @level1name = N'RK_Ticket_SalesReportStatus', @level2type = N'COLUMN', @level2name = N'CustomerEmail';


GO

