if database_principal_id('BI-HDL-ACCT-RevenueSharing-ExpertAnalysts') is null
begin
    create user [BI-HDL-ACCT-RevenueSharing-ExpertAnalysts] from external provider;
end;

