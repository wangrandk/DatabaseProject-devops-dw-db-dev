CREATE TABLE [stg].[ACCT_Settlement_Interval] (
    [JourneyRef]      CHAR (18)     NOT NULL,
    [From]            INT           NOT NULL,
    [To]              INT           NOT NULL,
    [Type]            NVARCHAR (50) NOT NULL,
    [PlannedDuration] FLOAT (53)    NOT NULL,
    [PartialDuration] FLOAT (53)    NOT NULL
);


GO

