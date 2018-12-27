
CREATE FUNCTION [dbo].[strToBool]
  (
  @str VARCHAR(20)
  )
RETURNS INT
AS
  BEGIN
    DECLARE @retval INT

    IF ( @str IS NULL )
      SET @retval = NULL
    ELSE IF ( @str = 'Y' )
      SET @retval = 1
    ELSE
      SET @retval = 0

    RETURN( @retval )
  END

