CREATE TABLE [stg].[QA_ServiceQuality_FileListArrival2TBD] (
    [FileListArrivalID]  INT            IDENTITY (1, 1) NOT NULL,
    [SourceSystemCode]   NVARCHAR (255) NULL,
    [FileName]           NVARCHAR (255) NULL,
    [FileModifyDateTime] DATETIME2 (0)  NULL,
    [ChangeDateTime]     DATETIME2 (7)  NULL
);


GO

