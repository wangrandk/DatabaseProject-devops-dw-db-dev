CREATE TABLE [stg].[QA_ServiceQuality_FileListDelta2TBD] (
    [FileListDeltaID]  INT            IDENTITY (1, 1) NOT NULL,
    [SourceSystemCode] NVARCHAR (255) NULL,
    [FileName]         NVARCHAR (255) NULL,
    [ChangeDateTime]   DATETIME2 (7)  NULL
);


GO

