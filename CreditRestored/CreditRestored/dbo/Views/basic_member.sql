
/****** Object:  View dbo.basic_member    Script Date: 10/13/99 6:38:01 PM ******/



CREATE VIEW basic_member
AS
    SELECT 
         [Member].[MemberNo]
      ,  [Member].lastname
      ,  [Member].firstname
      ,  [Member].middleinitial
      ,  [Member].street
      ,  [Member].city
      ,  [Member].state_prov
      ,  [Member].mail_code
      ,  [Member].phone_no
      ,  [Member].region_no
      ,  [Member].expr_dt
      ,  [Member].member_code
    FROM [Member]
    WHERE [MemberNo] NOT IN (SELECT [MemberNo] FROM corp_member)
