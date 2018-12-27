create proc [dbo].[usp_UpdateSysParameter_debugSw]
(
@debug_sw tinyint
)
as
begin
	UPDATE 
                                                           int_system_parameter 
                                                           SET 
                                                           debug_sw = @debug_sw 
                                                           WHERE 
                                                           system_parameter_id 
                                                           IN 
                                                           (1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 14)
end
