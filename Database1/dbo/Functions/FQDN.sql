CREATE FUNCTION [dbo].[FQDN] ()
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @Domain NVARCHAR(100);

    EXEC [master].[sys].[xp_regread] 'HKEY_LOCAL_MACHINE', 'SYSTEM\CurrentControlSet\services\Tcpip\Parameters', N'Domain', @Domain OUTPUT;
    IF (@Domain IS NOT NULL)
        RETURN (SELECT CAST(SERVERPROPERTY('MachineName') AS NVARCHAR) + '.' + @Domain );

    RETURN (SELECT CAST(SERVERPROPERTY('MachineName') AS NVARCHAR));
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieve the fully qualified domain name in which the server resides.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'FQDN';

