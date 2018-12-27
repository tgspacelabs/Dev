create proc [dbo].[usp_CEI_GetLicense]
as
    begin
        SELECT 
        product_cd 
        FROM 
        int_product_access 
        WHERE 
        product_cd = 'cei'
end
