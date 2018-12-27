
-- [GetUserbyUSID] is used to retrieve User details by user security identifier
CREATE PROCEDURE [dbo].[GetUserByUsId]
  (
  @user_sid VARCHAR(50)
  )
AS
  BEGIN
    SELECT user_id,
           user_role_id,
           login_name
    FROM   int_user
    WHERE  user_sid = @user_sid
  END


