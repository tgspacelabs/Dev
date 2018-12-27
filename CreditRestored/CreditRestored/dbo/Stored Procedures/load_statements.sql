
/****** Object:  Stored Procedure dbo.load_statements    Script Date: 10/13/99 6:38:03 PM ******/

CREATE PROCEDURE load_statements 
   @statement_dt datetime
AS
BEGIN
   DECLARE @batch_size int                 SELECT @batch_size = 100
   DECLARE @starting_member_no numeric_id  SELECT @starting_member_no = 1
   DECLARE @ending_member_no numeric_id    SELECT @ending_member_no = COUNT(*) FROM member
   DECLARE @member_no numeric_id           SELECT @member_no = @starting_member_no - 1

   SELECT @statement_dt = CONVERT(CHAR(12),@statement_dt,9)               --  Trim off the time.

   BEGIN TRANSACTION
   WHILE @member_no < @ending_member_no
   BEGIN
      SELECT @member_no = @member_no + 1

      IF @member_no % @batch_size = 0 
      BEGIN
         COMMIT TRANSACTION
         DUMP TRANSACTION credit WITH TRUNCATE_ONLY
         BEGIN TRANSACTION
      END

      EXEC generatestatement @member_no, @statement_dt
   END
   COMMIT TRANSACTION
   DUMP TRANSACTION credit WITH TRUNCATE_ONLY
END
