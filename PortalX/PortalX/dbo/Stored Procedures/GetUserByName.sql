CREATE PROCEDURE [dbo].[GetUserByName]
    (@login_name NVARCHAR(64))
AS
BEGIN
    SELECT
        [iu].[user_id],
        [iu].[user_role_id],
        [iu].[user_sid],
        [iu].[login_name],
        [iu].[LoginCount],
        [iur].[MaxLogins]
    FROM [dbo].[int_user] AS [iu]
        INNER JOIN [dbo].[int_user_role] AS [iur]
            ON [iu].[user_role_id] = [iur].[user_role_id]
    WHERE [iu].[login_name] = @login_name;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieve User details by User Login Name.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetUserByName';

