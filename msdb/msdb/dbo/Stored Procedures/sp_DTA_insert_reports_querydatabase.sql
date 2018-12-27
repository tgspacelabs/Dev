﻿create procedure sp_DTA_insert_reports_querydatabase
	@SessionID		int,
	@QueryID		int,
	@DatabaseID		int
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
	insert into [msdb].[dbo].[DTA_reports_querydatabase]([SessionID], [QueryID],[DatabaseID])
	values(@SessionID,@QueryID,@DatabaseID)
end	
