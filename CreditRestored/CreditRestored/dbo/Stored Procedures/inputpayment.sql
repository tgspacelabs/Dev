
/****** Object:  Stored Procedure dbo.inputpayment    Script Date: 10/13/99 6:38:03 PM ******/


CREATE PROCEDURE inputpayment
    @member_no        numeric_id   
  , @payment_dt       datetime     
  , @payment_amt      money        
AS 
BEGIN
  BEGIN TRANSACTION
  IF @@error = 0
    INSERT payment
        (  member_no,  payment_dt,  payment_amt )
      VALUES    
        ( @member_no, @payment_dt, @payment_amt )
  IF @@error = 0
    COMMIT TRANSACTION
  IF @@error = 0
    RETURN 0

  ROLLBACK TRANSACTION
  RAISERROR ('Stored procedure "inputpayment" failed', 16, -1)
  RETURN (-99)
END
