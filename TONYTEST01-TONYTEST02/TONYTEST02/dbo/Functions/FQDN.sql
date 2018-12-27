CREATE FUNCTION [dbo].[FQDN]()
RETURNS varchar(30)
AS
BEGIN
DECLARE @Domain NVARCHAR(100)

EXEC master.dbo.xp_regread 'HKEY_LOCAL_MACHINE', 'SYSTEM\CurrentControlSet\services\Tcpip\Parameters', N'Domain',@Domain OUTPUT
IF @Domain IS NOT NULL
return (SELECT Cast(SERVERPROPERTY('MachineName') as nvarchar) + '.' + @Domain )

return (SELECT Cast(SERVERPROPERTY('MachineName') as nvarchar))

END


