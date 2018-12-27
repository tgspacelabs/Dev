
/****** Object:  Stored Procedure dbo.generatestatement    Script Date: 10/13/99 6:38:03 PM ******/


CREATE PROCEDURE generatestatement 
    @member_no numeric_id
  , @statement_dt datetime  
AS
BEGIN
   DECLARE @due_dt datetime        SELECT @due_dt = DATEADD(day,20,@statement_dt)
   DECLARE @statement_amt money

   BEGIN TRANSACTION

   SELECT @statement_amt = ISNULL(SUM(charge_amt),0)
   FROM charge (TABLOCKX, HOLDLOCK)
   WHERE member_no = @member_no 
     AND statement_no = 0
     AND charge_dt <= @statement_dt

   INSERT statement (member_no        
                  ,  statement_dt     
                  ,  due_dt           
                  ,  statement_amt    
                  ,  statement_code
                  )
   VALUES (@member_no
        ,  @statement_dt
        ,  @due_dt
        ,  @statement_amt
        ,  ' '
        )

   UPDATE charge
   SET statement_no = @@IDENTITY
   WHERE member_no = @member_no 
     AND statement_no = 0
     AND charge_dt <= @statement_dt

   COMMIT TRANSACTION
END
