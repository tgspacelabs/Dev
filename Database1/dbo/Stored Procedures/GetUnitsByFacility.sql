
CREATE PROCEDURE [dbo].[GetUnitsByFacility]
    (
     @facility_id DFACILITY_ID,
     @login_name NVARCHAR(64)
    )
AS
SET NOCOUNT ON;

BEGIN
    SELECT
        [o].[organization_nm] AS [UNIT_NAME],
        [o].[organization_id] AS [UNIT_ID]
    FROM
        [dbo].[int_organization] AS [o]
    WHERE
        [o].[parent_organization_id] = @facility_id
        AND [o].[category_cd] = 'D'
        AND [o].[organization_id] NOT IN (SELECT
                                            [cdo].[organization_id]
                                          FROM
                                            [dbo].[cdr_restricted_organization] AS [cdo]
                                          WHERE
                                            ([cdo].[user_role_id] = (SELECT
                                                                [u].[user_role_id]
                                                               FROM
                                                                [dbo].[int_user] AS [u]
                                                               WHERE
                                                                [u].[login_name] = @login_name
                                                              )))
    ORDER BY
        [o].[organization_nm]; 
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetUnitsByFacility';

