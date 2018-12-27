
CREATE FUNCTION [dbo].[fnLocalDateTimeToUtcTime] ( @DateTime AS DATETIME ) 
RETURNS DateTime 
BEGIN  
	IF @DateTime IS NULL     
		RETURN NULL  
		RETURN DATEADD(mi, DATEDIFF(mi, GETDATE(), GETUTCDATE()), @DateTime)

END


