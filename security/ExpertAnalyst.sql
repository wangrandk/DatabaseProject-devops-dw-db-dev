CREATE ROLE [ExpertAnalyst]
    AUTHORIZATION [dbo];


GO

ALTER ROLE [ExpertAnalyst] ADD MEMBER [BI-HDL-RK-Transaction-ExpertAnalysts];


GO

ALTER ROLE [ExpertAnalyst] ADD MEMBER [BI-HDL-RK-ExpertAnalysts];


GO

ALTER ROLE [ExpertAnalyst] ADD MEMBER [BI-HG-ACCT-Settlement-ExpertAnalysts];


GO

ALTER ROLE [ExpertAnalyst] ADD MEMBER [BI-HDL-RT-SignalPriority-ExpertAnalyst];


GO

ALTER ROLE [ExpertAnalyst] ADD MEMBER [BI-HDL-ACCT-RevenueSharing-ExpertAnalysts];


GO

ALTER ROLE [ExpertAnalyst] ADD MEMBER [BI-HDL-RT-ExpertAnalyst];


GO

