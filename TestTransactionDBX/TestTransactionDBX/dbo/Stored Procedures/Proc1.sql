CREATE PROCEDURE [dbo].[Proc1]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Table1]
    SET [a] = 100 
    WHERE [a] = 10;

    SELECT
        [t1].[a],
        [t1].[b],
        [t1].[c]
    FROM
        [dbo].[Table1] AS [t1];

    SELECT
        [t2].[x],
        [t2].[y]
    FROM
        [dbo].[Table2] AS [t2];
END;