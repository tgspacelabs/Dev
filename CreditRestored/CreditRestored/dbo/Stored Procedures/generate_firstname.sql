/****** Object:  Stored Procedure dbo.generate_firstname    Script Date: 10/13/99 6:38:01 PM ******/



CREATE PROCEDURE generate_firstname 
   @firstname shortstring OUTPUT 
AS
BEGIN
   DECLARE @limit int
   DECLARE @curr_iteration int
   SELECT @limit = round((rand() * 20) + 3, 0)
   SELECT @curr_iteration = 0
   SELECT @firstname = ''
   WHILE @curr_iteration < @limit
   BEGIN
      SELECT @firstname = @firstname + char(round((rand() * 25) + 1, 0) + 64)
      SELECT @curr_iteration = @curr_iteration + 1
   END
   IF SUBSTRING(@firstname,1,1) = ' '
   BEGIN
      SELECT @firstname = SUBSTRING(@firstname,2,16)
   END
END
