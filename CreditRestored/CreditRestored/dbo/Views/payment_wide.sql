
/****** Object:  View dbo.payment_wide    Script Date: 10/13/99 6:38:01 PM ******/



CREATE VIEW payment_wide
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
      ,  payment.payment_no       
      ,  payment.payment_dt       
      ,  payment.payment_amt      

      ,  payment.payment_code
    FROM [Member], region, payment
    WHERE [Member].[MemberNo] = payment.member_no 
      AND region.region_no = [Member].region_no
