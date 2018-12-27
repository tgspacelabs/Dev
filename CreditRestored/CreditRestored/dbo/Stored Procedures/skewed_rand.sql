
/****** Object:  Stored Procedure dbo.skewed_rand    Script Date: 10/13/99 6:38:02 PM ******/



CREATE PROCEDURE skewed_rand 
    @max_value int
  , @skew_factor tinyint
AS
BEGIN
   DECLARE @rand_value int    SELECT @rand_value = @max_value
   WHILE (@skew_factor > 0)
   BEGIN
      SELECT @skew_factor = @skew_factor - 1
      EXEC @rand_value = straight_rand @rand_value
   END
   RETURN (@max_value - @rand_value) + 1
END
