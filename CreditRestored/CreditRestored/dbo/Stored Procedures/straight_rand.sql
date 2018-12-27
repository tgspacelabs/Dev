
/****** Object:  Stored Procedure dbo.straight_rand    Script Date: 10/13/99 6:38:02 PM ******/



CREATE PROCEDURE straight_rand 
    @max_value int
AS
BEGIN
   RETURN (rand() * (@max_value - 1)) + 1
END
