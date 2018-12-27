CREATE FUNCTION [dbo].[fntUtcDateTimeToLocalTime] (@DateTime AS DATETIME)
RETURNS TABLE 
RETURN
    SELECT
        DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), @DateTime) AS [LocalDateTime];
