
CREATE FUNCTION [dbo].[strToBool] (@str VARCHAR(20))
RETURNS INT
    WITH SCHEMABINDING
AS
BEGIN
    DECLARE @retval INT;

    IF (@str IS NULL)
        SET @retval = NULL;
    ELSE
        IF (@str = 'Y')
            SET @retval = 1;
        ELSE
            SET @retval = 0;

    RETURN @retval;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Convert string to boolean.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'FUNCTION', @level1name = N'strToBool';

