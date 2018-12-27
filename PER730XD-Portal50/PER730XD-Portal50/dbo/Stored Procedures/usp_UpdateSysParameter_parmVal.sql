create proc [dbo].[usp_UpdateSysParameter_parmVal]
(
@parm_value NVARCHAR(80),
@name NVARCHAR(30)
)
as
begin
    UPDATE
                                                            int_system_parameter
                                                            SET
                                                            parm_value =@parm_value
                                                            WHERE
                                                            UPPER(name) = @name
end
