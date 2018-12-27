
CREATE PROCEDURE [dbo].[usp_GetUnit]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [io1].[organization_cd] + ' - ' + [io].[organization_cd],
        [io].[organization_nm],
        [io].[organization_id],
        [io].[parent_organization_id],
        [io].[organization_cd]
    FROM
        [dbo].[int_organization] AS [io]
        INNER JOIN [dbo].[int_organization] AS [io1] ON [io].[parent_organization_id] = [io1].[organization_id]
    WHERE
        [io].[category_cd] = 'D';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetUnit';

