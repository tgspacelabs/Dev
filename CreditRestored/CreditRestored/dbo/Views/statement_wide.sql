
/****** Object:  View dbo.statement_wide    Script Date: 10/13/99 6:38:01 PM ******/



CREATE VIEW statement_wide
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
      ,  [Member].expr_dt
      ,  [Member].member_code
      ,  region.region_no
      ,  region.region_name
      ,  statement.statement_no     
      ,  statement.statement_dt     
      ,  statement.due_dt           
      ,  statement.statement_amt    
      ,  statement.statement_code      
    FROM [Member], region, statement
    WHERE [Member].[MemberNo] = statement.member_no 
      AND region.region_no = [Member].region_no
