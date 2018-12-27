
create procedure MS_PerfDashboard.usp_GetPageDetails @wait_resource varchar(100)
as
begin
	declare @database_id smallint, @file_id smallint, @page_no int
	declare @t TABLE (ParentObject varchar(256), Object varchar(256), Field varchar(256), VALUE sql_variant)

	declare @colon1 int, @colon2 int
	select @colon1 = charindex(':', @wait_resource)
	select @colon2 = charindex(':', @wait_resource, @colon1 + 1)
	select @database_id = substring(@wait_resource, 1, @colon1 - 1)
	select @file_id = substring(@wait_resource, @colon1 + 1, @colon2 - @colon1 - 1)
	select @page_no = substring(@wait_resource, @colon2 + 1, 100)
	
	BEGIN TRY
		insert into @t exec sp_executesql N'dbcc page(@database_id, @file_id, @page_no) with tableresults', N'@database_id smallint, @file_id smallint, @page_no int', @database_id, @file_id, @page_no
	END TRY
	BEGIN CATCH
		--do nothing
	END CATCH
	
	select @database_id as database_id, 
		quotename(db_name(@database_id)) as database_name,
		@file_id as file_id,
		@page_no as page_no,
		convert(int, [Metadata: ObjectId]) as [object_id], 
		quotename(object_schema_name(convert(int, [Metadata: ObjectId]), @database_id)) + N'.' + quotename(object_name(convert(int, [Metadata: ObjectId]), @database_id)) as [object_name],
		convert(smallint, [Metadata: IndexId]) as [index_id],
		convert(int, [m_level]) as page_level,
		case convert(int, [m_type])
			when 1 then N'Data Page'
			when 2 then N'Index Page'
			when 3 then N'Text Mix Page'
			when 4 then N'Text Tree Page'
			when 8 then N'GAM Page'
			when 9 then N'SGAM Page'
			when 10 then N'IAM Page'
			when 11 then N'PFS Page'
			else convert(nvarchar(10), [m_type])	-- other types intentionally omitted
		end as page_type
	from (select * from @t where ParentObject = 'PAGE HEADER:' and 
			Field IN ('Metadata: ObjectId', 'Metadata: IndexId', 'm_objId (AllocUnitId.idObj)', 'm_level', 'm_type')) as x
		pivot (min([VALUE]) for Field in ([Metadata: ObjectId], [Metadata: IndexId], [m_level], [m_type])) as z
end
