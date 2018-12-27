
-- [RestrictUnit] is used to save the restricted organization of a role
CREATE PROCEDURE [dbo].[RestrictUnit]
  (
  @user_role_id    UNIQUEIDENTIFIER,
  @organization_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    INSERT INTO cdr_restricted_organization
                (user_role_id,
                 organization_id)
    VALUES      (@user_role_id,
                 @organization_id);
  END


