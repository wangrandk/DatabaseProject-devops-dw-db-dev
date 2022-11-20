


CREATE view [data].[RT_SignalPriority_LogData_NoLock]
as(
select
    *
from
    [DW_EDW].[data].[RT_SignalPriority_LogData] (nolock)
    )
;

GO

