
CREATE VIEW [dim].[StopPoint_NoLock] AS
(
SELECT 
    *
FROM [DW_EDW].[dim].[StopPoint] WITH (NOLOCK)
)

GO

