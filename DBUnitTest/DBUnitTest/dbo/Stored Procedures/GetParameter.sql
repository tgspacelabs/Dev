CREATE PROCEDURE [dbo].[GetParameter] @Key NVARCHAR(50)
AS
BEGIN
    SELECT
        [Value]
    FROM
        [dbo].[Parameter]
    WHERE
        [Key] = @Key;

    RETURN 0;
END;
