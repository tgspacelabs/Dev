/****** Object:  View dbo.corp_member    Script Date: 10/13/99 6:38:01 PM ******/



/*
**  Create views for the credit database;
**    basic_member  -  Members, who do NOT have corporate cards.
**    corp_member  -  Members, who have their cards through a corporation.
**    statement_wide  -  Statements, widened to include member info.
**    payment_wide  -  Payments, widened to include member info.
**    charge_wide  -  charges, widened to include member and provider info.
**    overdue  -  Statement_wide, overdue.
**
**  One of these views is deliberately inefficient.  Rewording it
**  is one of the lab exercises.  Do not attempt to fix it here.
*/



CREATE VIEW corp_member
AS
    SELECT 
         [Member].[MemberNo]
      ,  [Member].lastname
      ,  [Member].firstname
      ,  [Member].middleinitial
      ,  corporation.corp_no          
      ,  corporation.corp_name             
      ,  corporation.street           
      ,  corporation.city             
      ,  corporation.state_prov            
      ,  corporation.mail_code              
      ,  corporation.phone_no         
      ,  corporation.expr_dt        
      ,  corporation.region_no        
      ,  corporation.corp_code
    FROM [Member], corporation
    WHERE corporation.corp_no = [Member].corp_no
