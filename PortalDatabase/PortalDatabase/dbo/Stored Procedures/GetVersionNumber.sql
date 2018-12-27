CREATE PROCEDURE [dbo].[GetVersionNumber]
AS
BEGIN
    SELECT TOP (1)
        [ver_code] AS [VERSION],
        [install_dt] AS [DT]
    FROM
        [dbo].[int_db_ver]
    ORDER BY
        [install_dt] DESC,
        [CreateDate] DESC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Returns the latest version number of the ICS database using the new CreateDate column to break the possible tie.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetVersionNumber';

