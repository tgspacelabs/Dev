
CREATE FUNCTION [dbo].[fnFileTimeToDateTime] (@DateTime AS BIGINT)
RETURNS DATETIME
    WITH SCHEMABINDING
BEGIN  
    IF @DateTime IS NULL
        RETURN NULL;  

    RETURN DATEADD(ms, ((@DateTime) / CAST(10000 AS BIGINT)) % 86400000, DATEADD(DAY, @DateTime / CAST(864000000000 AS BIGINT) - 109207, 0));
END; 

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Convert filetime to datetime format', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fnFileTimeToDateTime';

