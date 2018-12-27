
CREATE PROCEDURE [dbo].[usp_Delete_OrganizationEntityByCategory]
    (
     @organization_id UNIQUEIDENTIFIER,
     @category_Code CHAR(1)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
        [dbo].[int_organization]
    WHERE
        [organization_id] = @organization_id
        AND [category_cd] = @category_Code;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Delete_OrganizationEntityByCategory';

