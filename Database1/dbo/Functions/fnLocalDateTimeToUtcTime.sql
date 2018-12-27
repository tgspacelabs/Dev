
CREATE FUNCTION [dbo].[fnLocalDateTimeToUtcTime] (@DateTime AS DATETIME)
RETURNS DATETIME
    WITH SCHEMABINDING
BEGIN  
    IF (@DateTime IS NULL)
        RETURN NULL;  

    RETURN DATEADD(mi, DATEDIFF(mi, GETDATE(), GETUTCDATE()), @DateTime);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Convert the local datetime to UTC datetime.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fnLocalDateTimeToUtcTime';

