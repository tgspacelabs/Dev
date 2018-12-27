
CREATE FUNCTION [dbo].[fnFileTimeToDateTime] 
(     
@DateTime AS BIGINT 
) 
RETURNS DATETIME
BEGIN  
IF @DateTime IS NULL     
RETURN NULL  

RETURN DATEADD(ms, ((@DateTime) / CAST(10000 AS bigint)) % 86400000, 

DATEADD(day, @DateTime / CAST(864000000000 AS bigint) - 109207, 0)
)
END 

