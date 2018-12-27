create proc [dbo].[usp_GetFeaturelstForProducts]
as
begin
select 
    int_product_map.product_cd, 
    int_feature.feature_cd,
    int_feature.descr feature_descr 
    from 
    int_product_map, 
    int_feature 
    where 
    int_product_map.feature_cd = int_feature.feature_cd
end
