










CREATE procedure [integration].[AutoMerge]
        @Source nvarchar(255),
        @Target nvarchar(255),
        @UsingIndex nvarchar(255) = null,
        @Mode int = 1, -- 0 = Insert Only, 1 = Insert/Update, 2 = Insert/Update/Delete
		@IncludeColumns nvarchar(max) = null,
		@ExcludeColumns nvarchar(max) = null,
		@SkipMissingSourceColumns bit = 0,
		@TruncateSourceAfterMerge bit = 0,
        @Debug bit = 0
as
begin
    set nocount on;
	set xact_abort on;

    -- Written by Niklas Christoffer Petersen
    -- 2019-12-06

    -- Internal Constants
    declare @NewLine nchar(1) = char(13)
    declare @Identation nvarchar(32) = ''

    -- Internal Variables
    declare 
        @SourceSchema sysname = isnull(parsename(@Source, 2), schema_name()),
        @SourceTable sysname = parsename(@Source, 1),
        @TargetSchema sysname = isnull(parsename(@Target, 2), schema_name()),
        @TargetTable sysname = parsename(@Target, 1),
        @IndexId int;

    declare @Columns table(ColId int, ColumnName sysname, TypeName sysname, Bytes smallint)
    declare @MatchColumns as table(ColId int, ColumnName sysname)
    declare @SourceColumns table(ColumnName sysname)
    declare @SpecialColumns as table(ColumnName sysname, InsertValue nvarchar(max), UpdateValue nvarchar(max))
    
    declare @MatchOnList as nvarchar(max)
	declare @HashBytes as nvarchar(max)
    declare @ColumnList nvarchar(max)
    declare @EqualList nvarchar(max)
    declare @InsertList nvarchar(max)

	declare @Error as nvarchar(max)
    declare @Sql as nvarchar(max)

    -- Checking to see if the database name is specified along wih thetarget  table name
    -- Your database context should be local to the table for which you want to generate a MERGE statement
    -- specifying the database name is not allowed
    if parsename(@Target, 3) is not null begin
        raiserror('Do not specify the database name for target. Be in the target database and just specify the table name and optionally the schema name.', 16, 1)
        return -1 --Failure. Reason: Database name is specified along with the table name, which is not allowed
    end;

    if @UsingIndex is null
        select @IndexId = index_id, @UsingIndex = name from sys.indexes where object_id = object_id(@Target) and is_primary_key = 1;
    else
        select @IndexId = index_id from sys.indexes where object_id = object_id(@Target) and name = @UsingIndex and is_unique = 1;
         
    -- Validate mode
    if not @Mode between 0 and 2 begin
        raiserror ('The given @Mode is not supported. See documentation for supported modes.', 16, 1)
        return -1 --Failure. Reason: Nothing to merge on
    end;

    -- Validate index
    if @IndexId is null begin
        raiserror ('@UsingIndex must be a unique index. If omitted (null) there must exists a primary key index on target.', 16, 1)
        return -1 --Failure. Reason: Nothing to merge on
    end;

    -- Initialize special columns
    insert into @SpecialColumns (
        ColumnName,
        InsertValue,
        UpdateValue
    )
    values (
        'Inserted',
        'cast(sysdatetimeoffset() at time zone ''Central European Standard Time'' as datetime2(7))',
        null
    ),(
        'InsertedUtc',
        'sysutcdatetime()',
        null
    ),(
        'Updated',
        'cast(sysdatetimeoffset() at time zone ''Central European Standard Time'' as datetime2(7))',
        'cast(sysdatetimeoffset() at time zone ''Central European Standard Time'' as datetime2(7))'
    ),(
        'UpdatedUtc',
        'sysutcdatetime()',
        'sysutcdatetime()'
    )

	-- init working table
    delete from @Columns
    
    -- get list of columns in the target table.
    insert into @Columns ([ColId], [ColumnName], [TypeName], [Bytes])
	select
		c.column_id, 
		c.name, 
		type_name(c.user_type_id),
		c.max_length
	from
		sys.columns c
		left join string_split(@IncludeColumns, ',') incl on incl.value = c.name
		left join string_split(@ExcludeColumns, ',') excl on excl.value = c.name
	where
		c.object_id = object_id(@Target)
		and c.is_computed = 0
		and c.is_identity = 0   
		and (@IncludeColumns is null or incl.value is not null)
		and (@ExcludeColumns is null or excl.value is null)

	insert @MatchColumns select index_column_id, col_name(object_id, column_id) from sys.index_columns where object_id = object_id(@Target) and index_id = @IndexId and is_included_column = 0
    set @MatchOnList = null
    select @MatchOnList = coalesce(@MatchOnList + ' and t.[' + c.ColumnName +'] = s.[' + c.ColumnName +']', 't.[' + ColumnName + '] = s.[' + ColumnName + ']') from @MatchColumns c order by ColId

	-- get source columns
	set @Sql = 'select name from sys.columns where object_id = object_id(''' + @Source + ''')'
    insert @SourceColumns execute (@Sql)
    
	-- calculate hashbytes of all source columns (not in match columns)
	set @HashBytes = null
	if exists(select 1 from @Columns where ColumnName = 'Hash')
	begin
		-- @SkipMissingSourceColumns is not supported when target expects a hash (we would now know how to calculate the hash)
		if @SkipMissingSourceColumns = 1 begin
			set @Error = 'SkipMissingSourceColumns is not supported when target expects a hash (we would now know how to calculate the hash)'
			raiserror (@Error, 16, 1)
			return -1 --Failure. Reason: Nothing to merge on
		end;

		select
			@HashBytes = coalesce(@HashBytes + ' + ' + calc.[ColumnNameFormatted], calc.[ColumnNameFormatted])
		from
			@Columns c
			left join @MatchColumns i on c.ColumnName = i.ColumnName
			left join @SourceColumns s on s.ColumnName = c.ColumnName
			cross apply (
				select
					[ColumnNameFormatted] = case
						--when c.[TypeName] in ('nvarchar', 'nchar', 'varchar', 'char') then concat('s.[', c.ColumnName, ']')
						when c.[TypeName] in ('datetime2', 'time', 'datetimeoffset') then concat('isnull(0x01 + convert(varbinary(', c.Bytes + 1, '), s.[', c.ColumnName, ']), 0x00)')
						else concat('isnull(0x01 + convert(varbinary(', case when c.Bytes > 0 then convert(nvarchar(4), c.Bytes) else 'max' end, '), s.[', c.ColumnName, ']), 0x00)')
					end
			) calc
		where
			i.ColumnName is null -- Exclude match columns from hashbytes
			and s.ColumnName is not null -- Has a source column
		order by
			c.ColId

		set @HashBytes = 'hashbytes(''SHA2_256'', ' + @HashBytes + ')'

		-- add hash column as it would exist in source
		insert into @SourceColumns values ('Hash')
	end

	-- test for any missing columns in source
	set @ColumnList = null
	select
        @ColumnList = coalesce(@ColumnList + ', ' + [ColumnName], [ColumnName]) 
    from
	(
		select [ColumnName] from @Columns 
		except
		select [ColumnName] from @SourceColumns
		except
		select [ColumnName] from @SpecialColumns
	) missing_columns

    -- Validate all needed columns exists in source
    if @ColumnList is not null and @SkipMissingSourceColumns = 0 begin
		set @Error = 'The following columns in target was not found in source and are not known special columns: ' + @ColumnList
        raiserror (@Error, 16, 1)
        return -1 --Failure. Reason: Nothing to merge on
    end;
    
    set @Identation = '        '

    -- coalesce the equal columns (used to update the target)
    set @EqualList = null
    select top (10000) -- This top statement is neccessary for ensuring non-parallel execution, which yield incomplete lists
        @EqualList = coalesce(@EqualList + ',' + @NewLine + @Identation + 't.[' + c.ColumnName +'] = ' + isnull('s.[' + cast(s.ColumnName as nvarchar(max)) +']', g.UpdateValue), @Identation + 't.[' + c.ColumnName +'] = ' + isnull('s.[' + cast(s.ColumnName as nvarchar(max)) +']', g.UpdateValue))
    from
        @Columns c
        left join @MatchColumns i on c.ColumnName = i.ColumnName
		left join @SourceColumns s on s.ColumnName = c.ColumnName
        left join @SpecialColumns g on g.ColumnName = c.ColumnName
    where
        i.ColumnName is null -- Exclude match columns for update
        and (s.ColumnName is not null -- Has a source column
             or g.UpdateValue is not null) -- Or has a special source column
    order by
        c.ColId

    -- coalesce the columns
    set @ColumnList = null
    select top (10000) -- This top statement is neccessary for ensuring non-parallel execution, which yield incomplete lists
        @ColumnList = coalesce(@ColumnList + ',' + @NewLine + @Identation + '[' + c.ColumnName +']', @Identation + '[' + c.ColumnName + ']')
    from
        @Columns c
        left join @SourceColumns s on s.ColumnName = c.ColumnName
        left join @SpecialColumns g on g.ColumnName = c.ColumnName
    where
        s.ColumnName is not null -- Has a source column
        or g.InsertValue is not null -- Or has a special source column
    order by
        c.ColId

    -- coalesce the insert columns (used to insert the target)
    set @InsertList = null
    select top (10000) -- This top statement is neccessary for ensuring non-parallel execution, which yield incomplete lists
        @InsertList = coalesce(@InsertList + ',' + @NewLine + @Identation + isnull('s.[' + cast(s.ColumnName as nvarchar(max)) +']', g.InsertValue),  @Identation + isnull('s.[' + cast(s.ColumnName as nvarchar(max)) +']', g.InsertValue))
    from
        @Columns c
        left join @SourceColumns s on s.ColumnName = c.ColumnName
        left join @SpecialColumns g on g.ColumnName = c.ColumnName
    where
        s.ColumnName is not null -- Has a source column
        or g.InsertValue is not null -- Or has a special source column
    order by
        c.ColId

    set @Sql = '-- Generated by AutoMerge (ver. 0.3)'

    if @Debug = 1 begin
        declare @ModeDescription nvarchar(max) = case @Mode
            when 0 then 'Insert'
			when 1 then 'Insert/Update'
            when 2 then 'Insert/Update/Delete'
            else 'Unknown'
        end

        set @Sql += @NewLine + '----------------------------------------------------------------'
        set @Sql += @NewLine + '-- Debug Information:'
        set @Sql += @NewLine + '-- '
        set @Sql += @NewLine + '-- Mode: ' + cast(@Mode as nvarchar(1)) + ' (' + @ModeDescription + ')'
        set @Sql += @NewLine + '-- Using Index: ' + @UsingIndex
        set @Sql += @NewLine + '----------------------------------------------------------------'
    end;

	if @HashBytes is not null begin
		declare @SourceColumnList nvarchar(max)
		select 
			@SourceColumnList = coalesce(@SourceColumnList + ', ' + @NewLine + @Identation + 's.[' + c.[ColumnName] + ']', @Identation + 's.[' + c.[ColumnName] + ']')
		from
			@Columns c
			join @SourceColumns s on s.ColumnName = c.ColumnName
		where 
			c.[ColumnName] <> 'Hash'

		set @Sql += @NewLine + 'with [_Source] as ('
		set @Sql += @NewLine + '    select'
	    set @Sql += @NewLine + @SourceColumnList + ','
		set @Sql += @NewLine + '        [Hash] = ' + @HashBytes
		set @Sql += @NewLine + '    from'
		set @Sql += @NewLine + '        [' + @SourceSchema + '].[' + @SourceTable + '] s'
		set @Sql += @NewLine + ')'
		
		set @Sql += @NewLine + 'merge into [' + @TargetSchema + '].[' + @TargetTable + '] t'
		set @Sql += @NewLine + 'using [_Source] s'
		set @Sql += @NewLine + 'on ' + isnull(@MatchOnList, '<ERROR>')
		if @Mode in (1, 2) begin
			set @Sql += @NewLine + 'when matched and t.[Hash] <> s.[Hash] then'
		end
	end
	else begin
		set @Sql += @NewLine + 'merge into [' + @TargetSchema + '].[' + @TargetTable + '] t'
		set @Sql += @NewLine + 'using [' + @SourceSchema + '].[' + @SourceTable + '] s'
		set @Sql += @NewLine + 'on ' + isnull(@MatchOnList, '<ERROR>')
		if @Mode in (1, 2) begin
			set @Sql += @NewLine + 'when matched then'
		end
	end

	if @Mode in (1, 2) begin
    	set @Sql += @NewLine + '    update set '
		set @Sql += @NewLine + isnull(@EqualList, '<ERROR>')
	end
    set @Sql += @NewLine + 'when not matched by target then'
    set @Sql += @NewLine + '    insert ('
    set @Sql += @NewLine + isnull(@ColumnList, '<ERROR>') + ')'
    set @Sql += @NewLine + '    values ('
    set @Sql += @NewLine + isnull(@InsertList, '<ERROR>') + ')'
    
    if @Mode = 2 begin
        set @Sql += @NewLine + 'when not matched by source then'
        set @Sql += @NewLine + '    delete'
    end 

    set @Sql +=  @NewLine + ';'

	if @TruncateSourceAfterMerge = 1 begin
		set @Sql += @NewLine + @NewLine + 'truncate table [' + @SourceSchema + '].[' + @SourceTable + '];'
	end	

    if @Debug = 1
        print cast(@Sql as ntext)
    else
        execute (@Sql)
end

GO

