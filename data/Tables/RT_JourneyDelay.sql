CREATE TABLE [data].[RT_JourneyDelay] (
    [JourneyRef]                          CHAR (18)     NOT NULL,
    [SourceSystemCode]                    NVARCHAR (20) NOT NULL,
    [SourceSystemEntryRef]                BIGINT        NOT NULL,
    [DelayCaseNumber]                     INT           NOT NULL,
    [ExternalSourceSystemCode]            NVARCHAR (50) NULL,
    [SourceSystemDeviationCaseRef]        NVARCHAR (20) NULL,
    [DeviationReasonStandardCategoryCode] NVARCHAR (20) NULL,
    [DeviationReasonCustomCategoryName]   NVARCHAR (50) NULL,
    [CreatedUtcDateTime]                  DATETIME      NULL,
    [LastModifiedUtcDateTime]             DATETIME2 (3) NULL,
    [PlannedStartDateTime]                DATETIME2 (0) NULL,
    [JourneyPatternId]                    NUMERIC (16)  NULL,
    CONSTRAINT [PK_RT_JourneyDelay] PRIMARY KEY CLUSTERED ([JourneyRef] ASC, [SourceSystemCode] ASC, [SourceSystemEntryRef] ASC)
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [RT_JourneyDelay_JourneyRef_SourceSystemEntryRef]
    ON [data].[RT_JourneyDelay]([JourneyRef] ASC, [SourceSystemCode] ASC, [SourceSystemEntryRef] ASC);


GO

