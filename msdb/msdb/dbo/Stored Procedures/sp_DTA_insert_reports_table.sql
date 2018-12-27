﻿create procedure sp_DTA_insert_reports_table
	@SessionID	int,
	@DatabaseID	int,
	@SchemaName	sysname,
	@TableName	sysname,
	@IsView		bit
as
begin
	declare @retval  int							
	set nocount on

	exec @retval =  sp_DTA_check_permission @SessionID

	if @retval = 1
	begin
		raiserror(31002,-1,-1)
		return(1)
	end	
	insert into [msdb].[dbo].[DTA_reports_table]([DatabaseID], [SchemaName], [TableName], [IsView])
	values(@DatabaseID,@SchemaName,@TableName,@IsView)
end	
