create proc [dbo].[usp_GetCodeList]
(
@filters NVARCHAR(MAX)
)
as
begin
DECLARE @QUERY     NVARCHAR(MAX)
set @QUERY ='SELECT 
                                                                int_organization.organization_cd AS Facility,
                                                                int_send_sys.code AS System,
                                                                int_misc_code.category_cd AS Category,
                                                                int_misc_code.method_cd AS Method, 
                                                                int_misc_code.code AS Code,
                                                                int_misc_code.int_keystone_cd AS ''Internal Code'',
                                                                int_misc_code.short_dsc AS Description, 
                                                                ISNULL(int_misc_code.verification_sw,''0'') AS Verified,
                                                                int_misc_code.code_id as ID 
                                                                FROM 
                                                                int_misc_code 
                                                                LEFT OUTER JOIN int_send_sys 
                                                                            ON int_misc_code.sys_id = int_send_sys.sys_id 
                                                                LEFT OUTER JOIN int_organization 
                                                                            ON int_misc_code.organization_id = int_organization.organization_id '
                                                                if(len(@filters) >0)
                                                                begin
                                                                            set @QUERY = @QUERY + 'where '
                                                                            set @QUERY  = @QUERY + @filters
                                                                            exec(@QUERY)
                                                                end
                                                                else
                                                                exec(@QUERY)
                                                                    



end
