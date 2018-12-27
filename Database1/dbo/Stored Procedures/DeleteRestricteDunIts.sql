
-- [DeleteRestrictedUnits] is used to delete all the restricted organizations based on roleId
CREATE PROCEDURE [dbo].[DeleteRestricteDunIts]
    (
     @user_role_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM
        [dbo].[cdr_restricted_organization]
    WHERE
        [user_role_id] = @user_role_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Delete all the restricted organizations based on role ID.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteRestricteDunIts';

