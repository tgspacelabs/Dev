
USE [Database2];
GO

--INSERT  INTO [dbo].[Table1]
--        ([Table1ID],
--         [Description],
--         [UpdatedDate])
--VALUES
--        (0,
--         N'<DESCRIPTION, nvarchar(255),>',
--         SYSUTCDATETIME());
--GO

SELECT
    [Table1ID],
    DATALENGTH([Description]) AS [DATALENGTH],
    [Description],
    [UpdatedDate]
FROM
    [dbo].[Table1]
--ORDER BY
--    [DATALENGTH] DESC;
