create proc [dbo].[usp_GetMethodCode]
as
begin
    SELECT 
                                                DISTINCT method_cd 
                                                FROM 
                                                int_misc_code
                                                where 
                                                method_cd IS NOT NULL
                                                ORDER BY 
                                                method_cd
end
