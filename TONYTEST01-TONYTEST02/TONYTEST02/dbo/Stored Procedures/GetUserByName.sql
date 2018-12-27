
-- [GetUserbyName] is used to retrieve User details by User Login Name
CREATE PROCEDURE [dbo].[GetUserByName]
  (
  @login_name NVARCHAR(64)
  )
AS
  BEGIN
    SELECT user_id,
           user_role_id,
           user_sid,
           login_name
    FROM   int_user
    WHERE  login_name = @login_name;
  END


