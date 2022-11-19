
CREATE view dim.QA_DigitalSurvey_Vehicle_TEMP
as
select
    VehicleKey = -1
   ,TransPortMode = 'Unspecified'
   ,VehicleNumber = -1
   ,VehicleCode = 'Unspecified'
   ,Garage = 'Unspecified'
   ,Contractor = 'Unspecified'
union
select distinct
       VehicleKey = SourceSystemEntryRef + 10000000
      ,TransPortMode = 'Train'
      ,VehicleNumber = SurveyLinkMapping
      ,VehicleCode = TrainNumber
      ,Garage
      ,Contractor = Operator
from
    integration.QA_DigitalSurvey_TrainNumber_Bridge vt (nolock)
where
    vt.TrainNumber is not null
union
select distinct
       VehicleKey + 50000000
      ,TransportMode = 'Bus'
      ,VehicleNumber = InternalNumber
      ,VehicleCode = coalesce(nullif(RegistrationNumber, ''), try_cast(vb.InternalNumber as nvarchar(30)))
      ,Garage
      ,Contractor
from
    dim.RT_BusDatabase vb (nolock)
where
    IsCurrent = 1;

GO

