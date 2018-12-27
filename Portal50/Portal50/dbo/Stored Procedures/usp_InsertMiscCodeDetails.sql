CREATE PROC [dbo].[usp_InsertMiscCodeDetails]
(
	@codeId int,
	@organizationId UNIQUEIDENTIFIER,
	@sysId UNIQUEIDENTIFIER,
	@category_cd char(4),
	@method_cd NVARCHAR(10),
	@code NVARCHAR(80),
	@verification_sw tinyint=null,
	@int_keystone_cd NVARCHAR(80)=null,
	@short_dsc NVARCHAR(100)=null,
	@spc_pcs_code char(1)=null
)
AS
BEGIN
INSERT INTO int_misc_code
(
	code_id,
	organization_id,
	sys_id,
	category_cd,
	method_cd,
	code,
	verification_sw,
	int_keystone_cd,
	short_dsc,
	spc_pcs_code
) 
VALUES
(
	@codeId,
	@organizationId,
	@sysId,
	@category_cd,
	@method_cd,
	@code,
	@verification_sw,
	@int_keystone_cd,
	@short_dsc,
	@spc_pcs_code
)
END
