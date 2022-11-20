
CREATE view [fact].[QA_SQ_PassengerSurveyBase]
as
select
    InterviewId=i.Id
   ,i.SourceFileName
   ,i.InterviewerId
   ,i.RespondentId
   ,i.Time
   ,i.LineNumber
   ,i.VehicleRef
   ,i.ContractorCode
   ,i.GarageCode
   ,i.ContractCode
   ,i.FromStopPointId
   ,i.InterviewerStartStopId
   ,i.InterviewerEndStopId
   ,i.StartLongitude
   ,i.StartLatitude
   ,IsZeroed_I = i.IsZeroed
   ,IsDeleted_I = i.IsDeleted
   ,ModifiedAt_I = i.ModifiedAt
   ,i.DatedVehicleJourneyId
   ,i.JourneyRef
--,i.Inserted
--,i.Updated
--,i.Hash

from
    fact.QA_ServiceQuality_Interview i;

GO

