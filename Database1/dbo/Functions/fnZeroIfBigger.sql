
CREATE FUNCTION [dbo].[fnZeroIfBigger]
    (
     @value AS INT,
     @maxValue AS INT
    )
RETURNS INT
    WITH SCHEMABINDING
AS
BEGIN
    DECLARE @ret INT;

    IF @value > @maxValue
        SET @ret = 0;  
    ELSE
        SET @ret = @value;

    RETURN @ret;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Return 0 if value is greater than maxValue.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'fnZeroIfBigger';

