

CREATE FUNCTION [dbo].[fnUtcDateTimeToLocalTime] ( @DateTime AS DATETIME ) 
RETURNS DateTime 
BEGIN  
	IF @DateTime IS NULL     
		RETURN NULL  
		RETURN DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), @DateTime )
END


