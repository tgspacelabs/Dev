CREATE PROCEDURE [dbo].[usp_UpdateMiscCode]
(
@Organization_id UNIQUEIDENTIFIER,
@sys_id UNIQUEIDENTIFIER,
@category_cd char(4), 
@method_cd NVARCHAR(10), 
@code   NVARCHAR(80), 
@int_keystone_cd NVARCHAR(80), 
@short_dsc NVARCHAR(100), 
@verification_sw tinyint,
@code_id int
)
as
begin
	Update 
                                               int_misc_code 
                                               SET 
                                               Organization_id = @Organization_id, 
                                               sys_id = @sys_id,
                                               category_cd = @category_cd, 
                                               method_cd = @method_cd, 
                                               code = @code, 
                                               int_keystone_cd =@int_keystone_cd,
                                               short_dsc = @short_dsc,
                                               verification_sw = @verification_sw 
                                               WHERE 
                                               code_id = @code_id
end

