
/****** Object:  Stored Procedure dbo.removecorporation    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE removecorporation
    @corp_no    numeric_id
AS 
    DELETE corporation
      WHERE corp_no = @corp_no

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
