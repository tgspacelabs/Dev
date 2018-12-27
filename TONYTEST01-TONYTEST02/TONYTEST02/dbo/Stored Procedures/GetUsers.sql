

CREATE PROCEDURE [dbo].[GetUsers]
AS
  BEGIN
    SELECT user_id,
           user_role_id,
           user_sid,
           login_name
    FROM   int_user;
  END


