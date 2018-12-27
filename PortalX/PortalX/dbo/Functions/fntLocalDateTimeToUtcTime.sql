CREATE FUNCTION [dbo].[fntLocalDateTimeToUtcTime](@DateTime AS DATETIME)
RETURNS TABLE
WITH SCHEMABINDING
RETURN SELECT CASE
                  WHEN @DateTime IS NULL
                      THEN
                      NULL
                  ELSE
                      DATEADD(MINUTE, DATEDIFF(MINUTE, GETDATE(), GETUTCDATE()), @DateTime)
              END AS [UtcDateTime];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Convert the local datetime to UTC datetime.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fntLocalDateTimeToUtcTime';

