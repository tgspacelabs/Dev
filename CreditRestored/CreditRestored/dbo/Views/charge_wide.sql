
/****** Object:  View dbo.charge_wide    Script Date: 10/13/99 6:38:01 PM ******/



CREATE VIEW charge_wide
AS
    SELECT 
         [Member].[MemberNo]
      ,  [Member].lastname
      ,  [Member].firstname
      ,  region.region_no
      ,  region.region_name
      ,  provider.provider_name
      ,  category.category_desc
      ,  charge.charge_no        
      ,  charge.provider_no      
      ,  charge.category_no      
      ,  charge.charge_dt        
      ,  charge.charge_amt       
      ,  charge.charge_code
    FROM provider, [Member], region, category, charge
    WHERE [Member].[MemberNo] = charge.member_no 
      AND region.region_no = [Member].region_no
      AND provider.provider_no = charge.provider_no
      AND category.category_no = charge.category_no
