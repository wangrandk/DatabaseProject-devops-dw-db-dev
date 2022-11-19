
CREATE view fact.QA_DigitalSurvey_TEMP
as
select
    VehicleKey = isnull(d.VehicleKey, -1)
   --,t.TrainNumber
   --,calc.VehicleNumber -- = cast(coalesce(b.VehicleNumber, try_cast(f.VehicleNumber as int)) as int)
   --,CoverId = try_cast(f.VehicleNumber as int)
   ,VehicleNumberCoverId = f.VehicleNumber
   ,f.DigitalSurveyKey
   ,f.Survey
   ,f.Respondent
   ,f.StartTime
   ,f.CloseTime
   ,f.DiffTime
   ,f.SourceCreatedDatetime
   ,f.SourceModifiedDatetime
   ,f.VariableKey
   ,f.LableKey
   ,f.JourneyRef
   ,f.LineKey
   ,f.LineDirectionKey
   ,f.FromStopPointNumber
   ,f.ToStopPointNumber
   ,f.Email
   ,f.StartDateKey
   ,f.StartTimeKey
   ,f.JourneyPatternKey
   ,f.FromStopPointKey
   ,f.ToStopPointKey
   ,f.ContractorKey
   ,f.Stretch
   ,f.Hash
   ,f.Inserted
   ,f.Updated
   ,f.SentimentKey
   ,f.TrainTrackKey
   ,f.VariableText
from
    fact.QA_DigitalSurvey_Questionary f (nolock)
    left join integration.QA_DigitalSurvey_CoverIdVehicleNumberBridge b (nolock) on
        b.CoverId = try_cast(f.VehicleNumber as int)
    left join dim.RT_BusDatabase v (nolock) on
        v.InternalNumber = b.VehicleNumber
        and f.SourceCreatedDatetime between v.ValidFromDate and isnull(v.ValidToDate, '9999-12-31')
    cross apply (
    select
        VehicleNumber = cast(coalesce(b.VehicleNumber, try_cast(f.VehicleNumber as int)) as int)
) calc
    left join integration.QA_DigitalSurvey_TrainNumber_Bridge t (nolock) on
        t.SurveyLinkMapping = calc.VehicleNumber
    left join dim.QA_DigitalSurvey_Vehicle_TEMP d (nolock) on
        calc.VehicleNumber = d.VehicleNumber
where
    1 = 1;

GO

