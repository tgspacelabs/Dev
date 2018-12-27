
CREATE PROCEDURE [FindMyData]
    @DataToFind NVARCHAR(4000),
    @ExactMatch BIT = 0
AS
SET NOCOUNT ON;
 
CREATE TABLE [#Output]
    (
     [SchemaName] sysname,
     [TableName] sysname,
     [ColumnName] sysname
    );
 
IF ISDATE(@DataToFind) = 1
    INSERT  INTO [#Output]
            EXEC [FindMyData_Date]
                @DataToFind;
 
IF ISNUMERIC(@DataToFind) = 1
    INSERT  INTO [#Output]
            EXEC [FindMyData_Number]
                @DataToFind,
                @ExactMatch;
 
INSERT  INTO [#Output]
        EXEC [FindMyData_String]
            @DataToFind,
            @ExactMatch;
 
SELECT
    [SchemaName],
    [TableName],
    [ColumnName]
FROM
    [#Output]
ORDER BY
    [SchemaName],
    [TableName],
    [ColumnName];