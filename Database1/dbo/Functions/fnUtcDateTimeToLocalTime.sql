CREATE FUNCTION [dbo].[fnUtcDateTimeToLocalTime] (@DateTime AS DATETIME)
RETURNS DATETIME
    WITH SCHEMABINDING
BEGIN  
    --IF (@DateTime IS NULL)
    --    RETURN NULL;  

    RETURN DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), @DateTime);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Convert the UTC datetime to the local datetime.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fnUtcDateTimeToLocalTime';

