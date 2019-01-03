CREATE PROCEDURE [dbo].[uspInsertPerson]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Person]([FirstName], [LastName])
    VALUES (@FirstName, @LastName);

--SELECT [p].[PersonID], [p].[FirstName], [p].[LastName], [p].[Created], [p].[Updated] 
--    FROM [dbo].[Person] AS [p];

    RETURN 0
END
