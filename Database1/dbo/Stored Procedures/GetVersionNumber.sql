

CREATE PROCEDURE [dbo].[GetVersionNumber]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (1)
        [ver_code] AS [VERSION],
        [install_dt] AS [DT]
    FROM
        [dbo].[int_db_ver]
    ORDER BY
        [install_dt] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetVersionNumber';

