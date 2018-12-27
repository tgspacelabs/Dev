
/****** Object:  Stored Procedure dbo.removecategory    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE removecategory
    @category_no    numeric_id
AS 
    DELETE category
      WHERE category_no = @category_no

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
