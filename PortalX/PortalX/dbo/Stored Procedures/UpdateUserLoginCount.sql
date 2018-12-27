CREATE PROCEDURE [dbo].[UpdateUserLoginCount]
    (
    @user_sid VARCHAR(50),
    @login_name NVARCHAR(64),
    @increment SMALLINT)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[int_user]
    SET [LoginCount] = [LoginCount] + @increment
    WHERE [user_sid] = @user_sid
          OR [login_name] = @login_name;
END;
