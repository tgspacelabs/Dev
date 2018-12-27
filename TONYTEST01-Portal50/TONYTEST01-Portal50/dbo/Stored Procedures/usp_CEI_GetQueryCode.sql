create proc [dbo].[usp_CEI_GetQueryCode]
as
begin
select 
code_id, 
short_dsc, 
int_keystone_cd
from 
int_misc_code 
where 
int_misc_code.method_cd='GDS' 
and 
int_misc_code.verification_sw IS NOT NULL 
and 
short_dsc IS NOT NULL
end
