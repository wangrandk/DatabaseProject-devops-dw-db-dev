CREATE ROLE [RT_Journey_ExpertAnalyst]
    AUTHORIZATION [dbo];


GO

ALTER ROLE [RT_Journey_ExpertAnalyst] ADD MEMBER [BI-HDL-RK-ExpertAnalysts];


GO

ALTER ROLE [RT_Journey_ExpertAnalyst] ADD MEMBER [BI-HDL-RT-ExpertAnalyst];


GO

ALTER ROLE [RT_Journey_ExpertAnalyst] ADD MEMBER [BI-HDL-RK-Transaction-ExpertAnalysts];


GO

