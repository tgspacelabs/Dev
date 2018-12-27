
/****** Object:  Stored Procedure dbo.inputcharge    Script Date: 10/13/99 6:38:03 PM ******/


CREATE PROCEDURE inputcharge
    @member_no        numeric_id   
  , @provider_no      numeric_id   
  , @category_no      numeric_id   
  , @charge_dt        datetime     
  , @charge_amt       money        
AS 
BEGIN
  BEGIN TRANSACTION
  IF @@error = 0
    INSERT charge 
        (  member_no,  provider_no,  category_no,  charge_dt,  charge_amt )
      VALUES    
        ( @member_no, @provider_no, @category_no, @charge_dt, @charge_amt )
  IF @@error = 0
    COMMIT TRANSACTION
  IF @@error = 0
    RETURN 0

  ROLLBACK TRANSACTION
  RAISERROR ('Stored procedure "inputcharge" failed', 16, -1)
  RETURN (-99)
END
