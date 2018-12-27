﻿create procedure sp_DTA_set_tuningresults
	@SessionID int,	
	@FinishStatus tinyint,
	@LastPartNumber int
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
	
	Insert into [msdb].[dbo].[DTA_tuningresults]([SessionID], [LastPartNumber],[FinishStatus]) values(@SessionID,@LastPartNumber,@FinishStatus)
end	
