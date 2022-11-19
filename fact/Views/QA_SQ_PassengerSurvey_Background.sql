
CREATE view fact.QA_SQ_PassengerSurvey_Background
as
select
    l.InterviewId
   --,l.RespondentId
   ,l.QuestionId
   ,l.SurveyQuestionType
   ,l.AnswerValue
   ,ModifiedAt_L = l.ModifiedAt
   ,IsZeroed_L = l.IsZeroed
   ,IsDeleted_L = l.IsDeleted
   --,l.Inserted
   --,l.Updated
   --,l.Hash
   ,q.QuestionKey
   ,q.SourceSystemCode
   ,q.SourceSystemEntryRef
   --,q.QuestionId
   ,q.QuestionIndex
   ,q.QuestionTextAlt1
   ,q.QuestionTextAlt2
   ,q.QuestionTypeId
   ,q.QuestionTypeName
   ,q.IsVisible
   ,q.CreatedAt
   ,ModifiedAt_Q = q.ModifiedAt
--,q.Inserted
--,q.Updated
--,q.Hash
from
    fact.QA_ServiceQuality_InterviewLine l
    left join dim.QA_ServiceQuality_Question q on
        q.QuestionId = l.QuestionId
-- AND q.questiontypeid = l.answergroupid
where
    1 = 1
    and QuestionTypeName like '%baggrund%';

GO

