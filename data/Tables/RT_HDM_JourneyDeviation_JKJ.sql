CREATE TABLE [data].[RT_HDM_JourneyDeviation_JKJ] (
    [Id]                                  NUMERIC (16)   NOT NULL,
    [JourneyRef]                          CHAR (18)      NULL,
    [DatedVehicleJourneyId]               NUMERIC (16)   NULL,
    [DeviationCaseGid]                    NUMERIC (16)   NULL,
    [VehicleRef]                          NVARCHAR (50)  NULL,
    [ApprovedState]                       SMALLINT       NULL,
    [Cancelled]                           SMALLINT       NULL,
    [Assigned]                            BIT            NULL,
    [DelaySeconds]                        INT            NULL,
    [DeviationReasonStandardCategoryCode] NVARCHAR (50)  NULL,
    [DeviationReasonCustomCategoryName]   NVARCHAR (50)  NULL,
    [Comment]                             NVARCHAR (255) NULL,
    [ReportedByInitials]                  NVARCHAR (50)  NULL,
    [ReportedByServiceCenterCode]         NVARCHAR (8)   NULL,
    [ReportedDateTime]                    DATETIME       NULL,
    [SavedByInitials]                     NVARCHAR (50)  NULL,
    [SavedDateTime]                       DATETIME       NULL,
    [IsFinalState]                        BIT            NULL,
    [ReportedDeviationId]                 NUMERIC (16)   NULL,
    [WithholdPayment]                     BIT            NULL,
    [ConcernsArrivals]                    BIT            NULL,
    [ConcernsDepartures]                  BIT            NULL,
    [FromSequenceNumber]                  INT            NULL,
    [FromJourneyPatternPointGid]          NUMERIC (16)   NULL,
    [FromJourneyPointRef]                 CHAR (22)      NULL,
    [UptoSequenceNumber]                  INT            NULL,
    [UpToJourneyPatternPointGid]          NUMERIC (16)   NULL,
    [UptoJourneyPointRef]                 CHAR (22)      NULL,
    [PlannedDurationSeconds]              INT            NULL,
    [UpdateTimeStamp]                     DATETIME       NULL,
    CONSTRAINT [PK_RT_HDM_JourneyDeviation_JKJ] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO

