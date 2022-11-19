CREATE VIEW [dim].[APC_CountingReport_Period] AS


SELECT DISTINCT
    cr.[Period]
   ,d.[Year]
   ,d.[YearQuarter] as [YearMonth] 
FROM
    [DW_EDW].[dim].[Date] as d
    JOIN [DW_EDW].[fact].[APC_CountingReport] as cr ON
        cr.[Period] = d.[YearQuarterNo]
UNION
SELECT DISTINCT
    cr_.[Period]
   ,d_.[Year]
   ,d_.[YearMonth] as [YearMonth] 
FROM
    [DW_EDW].[dim].[Date] as d_
    JOIN [DW_EDW].[fact].[APC_CountingReport] as cr_ ON
        cr_.[Period] = d_.[YearMonthNo]
;

GO

