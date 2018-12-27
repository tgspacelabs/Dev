
/****** Object:  Stored Procedure dbo.load_payments    Script Date: 10/13/99 6:38:03 PM ******/

CREATE PROCEDURE load_payments 
    @starting_dt datetime
  , @ending_dt datetime
AS
BEGIN
   DECLARE @batch_size int                   SELECT @batch_size = 1000

   DECLARE @member_no numeric_id
   DECLARE @due_dt datetime
   DECLARE @statement_amt money

   DECLARE @highest_member_no numeric_id     SELECT @highest_member_no = COUNT(*) FROM member

   DECLARE @starting_member_no numeric_id  SELECT @starting_member_no = 1
   DECLARE @ending_member_no numeric_id    SELECT @ending_member_no = @batch_size

   SELECT @starting_dt = CONVERT(CHAR(12),@starting_dt,9)
   SELECT @ending_dt = CONVERT(CHAR(12),@ending_dt,9)    

   DECLARE statements_cursor CURSOR FOR 
      SELECT member_no, due_dt, statement_amt
      FROM statement
      WHERE member_no BETWEEN @starting_member_no AND @ending_member_no
        AND statement_dt > @starting_dt AND statement_dt <= @ending_dt 
        AND statement_amt > 0

   WHILE @starting_member_no <= @highest_member_no
   BEGIN
      BEGIN TRANSACTION
      OPEN statements_cursor

      WHILE (@@FETCH_STATUS = @@FETCH_STATUS)
      BEGIN
         FETCH NEXT FROM statements_cursor INTO @member_no, @due_dt, @statement_amt
         IF (@@FETCH_STATUS <> 0)
            BREAK
         EXEC inputpayment @member_no, @due_dt, @statement_amt
      END

      CLOSE statements_cursor
      COMMIT TRANSACTION
      DUMP TRANSACTION credit WITH NO_LOG

      SELECT @starting_member_no = @ending_member_no + 1
      SELECT @ending_member_no = @ending_member_no + @batch_size
   END

   DEALLOCATE statements_cursor
END
