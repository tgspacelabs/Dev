CREATE PROCEDURE [dbo].[GetFacilities]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [org].[organization_id] AS [FACILITY_ID],
        [org].[organization_cd] AS [FACILITY_CODE],
        [org].[organization_nm] AS [FACILITY_NAME]
    FROM
        [dbo].[int_organization] AS [org]
    WHERE
        [org].[category_cd] = 'F'
    ORDER BY
        [org].[organization_cd];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetFacilities';

