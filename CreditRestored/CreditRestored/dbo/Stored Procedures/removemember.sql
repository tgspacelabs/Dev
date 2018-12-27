
/****** Object:  Stored Procedure dbo.removemember    Script Date: 10/13/99 6:38:03 PM ******/


CREATE PROCEDURE removemember
    @member_no    numeric_id
AS 
    DELETE [Member]
      WHERE [MemberNo] = @member_no

    IF @@error != 0
       RETURN (-99)
    ELSE
       RETURN 0
