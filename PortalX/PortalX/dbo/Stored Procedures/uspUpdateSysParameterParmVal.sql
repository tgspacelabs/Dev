CREATE PROCEDURE [dbo].[uspUpdateSysParameterParmVal]
    (
    @parm_value NVARCHAR(80),
    @name NVARCHAR(30))
AS
BEGIN
    UPDATE [dbo].[int_system_parameter]
    SET [parm_value] = @parm_value
    WHERE [name] = @name;
END;
GO
EXECUTE [sys].[sp_addextendedproperty]
    @name = N'MS_Description',
    @value = N'',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'PROCEDURE',
    @level1name = N'uspUpdateSysParameterParmVal';
