create view [data].[RT_SignalPriority_Completeness] as 
select	MoviaCount.Date,
		MoviaCount.LightId, 
		MoviaCount.MoviaCount, 
		KKCount.KKCount 
from

(select * from (
select
    Movia.Date
   ,Movia.LightId
   ,MoviaCount = count(Movia.LightId)
from (
    select
        a.SourceSystemCode
       ,a.LogTime
       ,a.DataFlowDirection
       ,a.Username
       ,a.ActivationTime
       ,Date = cast(a.ActivationTime as date)
       ,Time = cast(a.ActivationTime as time)
       ,Hour = datepart(hour, a.ActivationTime)
       ,Day = datename(dw, a.ActivationTime)
       ,a.LightId
       ,a.RelayNumber
       ,a.Type
       ,Event = case
                    when a.Type = 1
                        then 'CI'
                    when a.Type = 2
                        then 'CO'
                    else 'UNK'
                end
       ,a.LineDesignation
       ,a.JourneyNumber
       ,a.VehicleNumber
    from
        DW_EDW.data.RT_SignalPriority_Activation as a
    where
        cast(a.LogTime as datetime2) between cast(getdate() - 7 as date) and cast(getdate() as date)
        and a.LightId in
            (
                select distinct
                    LightId
                from
                    DW_EDW.dim.RT_SignalPriority_ActivationPoint
                where
                    ActivationType = 1
                    and IsCurrent = 1
                    and MunicipalityName = 'København'
            ) 
        and a.SourceSystemCode = 'RPS'
        and a.Type = 1
) as Movia
group by
    Movia.Date
   ,Movia.LightId
) as MoviaCount
) as MoviaCount left join
(select * from (select
    KK.Date
   ,KK.LightId
   ,KKCount = count(KK.LightId)
from (
    select
        S.LightId
       ,S.IntersectionDirection
       ,S.Event
       ,S.Line
       ,S.Punctuality
       ,S.Vehicle
       ,S.Provider
       ,S.ErrorCode
       ,S.DateTime
       ,Date = cast(DateTime as date)
       ,Time = cast(DateTime as time)
       ,Hour = datepart(hour, DateTime)
       ,Day = datename(dw, DateTime)
    from
        DW_EDW.data.RT_SignalPriority_LogData as S
    where
        S.DateTime between cast(getdate() - 7 as date) and cast(getdate() as date)
        and LightId in
            (
                select distinct
                    LightId
                from
                    DW_EDW.dim.RT_SignalPriority_ActivationPoint
                where
                    ActivationType = 1
                    and IsCurrent = 1
                    and MunicipalityName = 'København'
            )
        and S.TrafficCategory = 'PT'
        and S.VehicleType = 1
        and S.Event = 'CI'
) as KK
group by
    KK.Date
   ,KK.LightId
) as KKCount) as KKCount on MoviaCount.LightId = KKCount.LightId and MoviaCount.Date = KKCount.Date

GO

