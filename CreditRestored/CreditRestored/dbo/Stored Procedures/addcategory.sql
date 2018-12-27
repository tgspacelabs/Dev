
/****** Object:  Stored Procedure dbo.addcategory    Script Date: 10/13/99 6:38:02 PM ******/


CREATE PROCEDURE addcategory
    @category_desc    shortstring
AS 
    INSERT category
        (  category_desc)
      VALUES    
        ( @category_desc)

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
