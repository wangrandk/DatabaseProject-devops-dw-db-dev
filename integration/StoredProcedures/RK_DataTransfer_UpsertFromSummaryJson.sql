-- =============================================
-- Author:      Niklas Christoffer Petersen
-- Create Date: 2022-04-06
-- Description: Upserts multiple state-tables from an JSON-representation of an Data Export Summar File.
-- =============================================
CREATE procedure [integration].[RK_DataTransfer_UpsertFromSummaryJson]
(
    @containerName nvarchar(255)
   ,@summaryJson nvarchar(max)
   ,@containerLastModifiedUtc datetime2(3) = null
   ,@containerSize bigint = null
)
as
begin
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    set nocount on;

    -- Strip zip-extension off container name
    if right(@containerName, 4) = '.zip'
        set @containerName = substring(@containerName, 1, len(@containerName) - 4);

    -- Create table variable to store container name parts
    declare @parts table(ix int identity(1,1) not null, part nvarchar(max));
    insert into @parts (part) select [value] from string_split(@containerName, '-')

    declare @containerDate date;
    declare @containerNumber int;

    set @containerNumber = try_cast((select [part] from @parts where ix = 3) as int);
    set @containerDate = try_cast((select [part] from @parts where ix = 4) as date);

    -- Upsert Container State
    with
    [stg] as
    (
        select
            [ContainerName] = @containerName
           ,[ContainerDate] = @containerDate
           ,[ContainerNumber] = @containerNumber
           ,[DataGroup] = json_value(@summaryJson, '$.DataExportFile.DataGroup."@Name"')
           ,[SdmVersion] = json_value(@summaryJson, '$.DataExportFile."@SDMVersion"')
           ,[DisVersion] = json_value(@summaryJson, '$.DataExportFile."@DISVersion"')
           ,[SummaryJson] = @summaryJson
           ,[LastModifiedUtc] = @containerLastModifiedUtc
           ,[Size] = @containerSize
    )
    merge [integration].[RK_DataTransfer_ContainerState] t
    using [stg] s
    on (t.[ContainerName] = s.[ContainerName])
    when matched and isnull(t.[LastModifiedUtc], '1900-01-01 00:00:00') <> s.[LastModifiedUtc]
                     and isnull(t.[Size], 0) <> s.[Size] then update set
                                                                  [LastModifiedUtc] = s.[LastModifiedUtc]
                                                                 ,[Size] = s.[Size]
                                                                 ,[State] = 1
    when not matched by target then
        insert (
            [ContainerName]
           ,[ContainerDate]
           ,[ContainerNumber]
           ,[DataGroup]
           ,[SdmVersion]
           ,[DisVersion]
           ,[LastModifiedUtc]
           ,[Size]
           ,[SummaryJson]
           ,[InsertedUtc]
           ,[UpdatedUtc]
           ,[State]
        )
        values
        (
            s.[ContainerName]
           ,s.[ContainerDate], s.[ContainerNumber], s.[DataGroup], s.[SdmVersion], s.[DisVersion]
           ,s.[LastModifiedUtc], s.[Size], s.[SummaryJson], sysutcdatetime(), sysutcdatetime(), 1
        );

end;

GO

