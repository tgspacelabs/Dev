create proc [dbo].[usp_GetSysgenDetails]
(
@product_cd varchar(25)
)
as
begin
    select * 
                                                from
                                                int_sysgen 
                                                where
                                                product_cd = @product_cd 
                                                ORDER BY 
                                                feature_cd
end
