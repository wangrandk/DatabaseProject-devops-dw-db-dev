CREATE TABLE [stg].[QA_DigitalSurvey_BusWeb] (
    [survey]   INT             NOT NULL,
    [responde] INT             NOT NULL,
    [created]  DATETIME        NULL,
    [modified] DATETIME        NULL,
    [starttim] DATETIME        NULL,
    [closetim] DATETIME        NULL,
    [difftime] FLOAT (53)      NULL,
    [s_1]      NVARCHAR (4000) NULL,
    [s_2]      NVARCHAR (4000) NULL,
    [s_3]      NVARCHAR (MAX)  NULL,
    [s_4]      NVARCHAR (4000) NULL,
    [s_5]      NVARCHAR (MAX)  NULL,
    [s_6]      NVARCHAR (4000) NULL,
    [s_7]      NVARCHAR (4000) NULL,
    [s_8]      NVARCHAR (4000) NULL,
    [s_9]      NVARCHAR (4000) NULL,
    [s_10]     NVARCHAR (4000) NULL,
    [s_11]     NVARCHAR (4000) NULL,
    [s_12]     NVARCHAR (4000) NULL,
    [s_13]     NVARCHAR (4000) NULL,
    [email]    NVARCHAR (4000) NULL,
    [s_14]     NVARCHAR (4000) NULL
);


GO

