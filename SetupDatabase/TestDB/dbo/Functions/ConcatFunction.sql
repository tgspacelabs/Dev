CREATE FUNCTION dbo.ConcatFunction (@Name SYSNAME)
RETURNS NVARCHAR(MAX)
    WITH SCHEMABINDING
AS
BEGIN
    DECLARE @s NVARCHAR(MAX);
 
    SELECT
        @s = COALESCE(@s + N', ', N'') + Pet
    FROM
        dbo.FamilyMemberPets
    WHERE
        Name = @Name
    ORDER BY
        Pet;
 
    RETURN (@s);
END