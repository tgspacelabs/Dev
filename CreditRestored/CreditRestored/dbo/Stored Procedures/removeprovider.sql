
/****** Object:  Stored Procedure dbo.removeprovider    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE removeprovider
    @provider_no    numeric_id
AS 
    DELETE provider
      WHERE provider_no = @provider_no

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
