CREATE TABLE [data].[RT_Signal] (
    [SignalId] INT               NOT NULL,
    [Name]     NUMERIC (5, 2)    NOT NULL,
    [Location] VARCHAR (59)      NULL,
    [Center]   [sys].[geography] NOT NULL,
    CONSTRAINT [PK__RT_Signa__3A623005013622FC] PRIMARY KEY CLUSTERED ([SignalId] ASC)
);


GO

