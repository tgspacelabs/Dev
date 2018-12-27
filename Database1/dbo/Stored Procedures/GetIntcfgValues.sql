
CREATE PROCEDURE [dbo].[GetIntcfgValues] (@keyname DKEY_NAME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [icv].[keyvalue] AS [KEY_VALUE]
    FROM
        [dbo].[int_cfg_values] AS [icv]
    WHERE
        [icv].[keyname] = @keyname;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetIntcfgValues';

