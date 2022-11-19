CREATE TABLE [stg].[ACCT_Settlement] (
    [JourneyRef]         CHAR (18)     NOT NULL,
    [Class]              NVARCHAR (2)  NOT NULL,
    [PlannedDuration]    FLOAT (53)    NOT NULL,
    [Payment]            FLOAT (53)    NOT NULL,
    [PaymentPct]         FLOAT (53)    NOT NULL,
    [SubPaymentCategory] NVARCHAR (50) NULL,
    [SubPaymentDuration] FLOAT (53)    NULL
);


GO

