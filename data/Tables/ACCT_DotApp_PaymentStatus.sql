CREATE TABLE [data].[ACCT_DotApp_PaymentStatus] (
    [Id]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [State]          INT              NOT NULL,
    [PaidAmount]     INT              NOT NULL,
    [RefundedAmount] INT              NOT NULL,
    [ModifiedOn]     DATETIME2 (7)    NOT NULL,
    [CreatedOn]      DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_ACCT_DotApp_PaymentStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO

