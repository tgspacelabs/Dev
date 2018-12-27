
-- [GetUserbyGUID] is used to retrieve User details by User ID
CREATE PROCEDURE [dbo].[GetUserByguId]
  (
  @user_id VARCHAR(50)
  )
AS
  BEGIN
    SELECT user_id,
           login_name,
           user_role_id,
           user_sid
    FROM   int_user
    WHERE  user_id = @user_id;
  END


