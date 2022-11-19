


-- =============================================
-- Author:      Anne Hjorth Nielsen
-- Create Date: 2022-06-16
-- Description: Inserts / Updates [data].[APC_OTS_DailyVehicleBalanc] based on CountingReport timestamped on a date between @fromUtcDate and @toUtcDate
-- =============================================
CREATE procedure [data].[APC_OTS_DailyVehicleBalance_UpsertFromCountingReport] (@fromUtc date, @toUtc date)
as
begin

    truncate table [stg].[APC_OTS_DailyVehicleBalance];

    insert into
        [stg].[APC_OTS_DailyVehicleBalance]
    (
        [Date]
       ,[VehicleRef]
       ,[DailyVehicleBoardingCount]
       ,[DailyVehicleAlightingCount]
       ,[DailyVehicleBalance]
    )
    select
        [Date] = cast([DateTime] as date)
       ,[VehicleRef]
       ,[DailyVehicleBoardingCount] = sum([BoardingCount])
       ,[DailyVehicleAlightingCount] = sum([AlightingCount])
       ,[DailyVehicleBalance] = iif(sum([BoardingCount]) + sum([AlightingCount]) > 0
                                   ,1 - abs(1.0 * (sum([BoardingCount]) - sum([AlightingCount])))
                                    / (sum([BoardingCount]) + sum([AlightingCount]))
                                   ,null)
    from
        [data].[APC_OTS_CountingReport]
    where
		[MatchedLocationContractorRef] is null
        and @fromUtc <= [DateTime] and [DateTime] < dateadd(day, 1, @toUtc)
    group by
        cast([DateTime] as date)
       ,[VehicleRef];

    exec [integration].[AutoMerge]
        @Source = '[stg].[APC_OTS_DailyVehicleBalance]'
       ,@Target = '[data].[APC_OTS_DailyVehicleBalance]'
       ,@Mode = 1
       ,@TruncateSourceAfterMerge = 1;

end;

GO

