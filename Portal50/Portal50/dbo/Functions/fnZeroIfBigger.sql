
CREATE FUNCTION [dbo].[fnZeroIfBigger]
(
	@value as int,
	@maxValue as int
)
RETURNS int
AS
BEGIN

IF @value > @maxValue     
RETURN 0  

return @value

END

