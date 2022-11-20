

CREATE view [data].[RT_SignalPriority_Activation_NoLock]
as(
select
    *
from
    [DW_EDW].[data].[RT_SignalPriority_Activation]
    )
;

GO

