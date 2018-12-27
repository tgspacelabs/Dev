CREATE FUNCTION [dbo].[fnDateTimeToFileTime] (@DateTime AS DATETIME)
RETURNS BIGINT
    WITH SCHEMABINDING
BEGIN  
    IF (@DateTime IS NULL)
        RETURN NULL;  

    DECLARE
        @MsecBetween1601And1970 BIGINT = 11644473600000,
        @MsecBetween1970AndDate BIGINT;

    SET @MsecBetween1970AndDate = DATEDIFF(ss, CAST('1970-01-01 00:00:00' AS DATETIME), @DateTime) * CAST(1000 AS BIGINT) + DATEPART(Ms, @DateTime);

    RETURN (@MsecBetween1601And1970 + @MsecBetween1970AndDate) * CAST(10000 AS BIGINT);
END; 

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Convert datetime to filetime format', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fnDateTimeToFileTime';

