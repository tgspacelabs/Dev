create proc [dbo].[usp_UpdateOrg]
(
@organizationCd NVARCHAR(20),
@organizationNm  NVARCHAR(50),
@organizationId UNIQUEIDENTIFIER
)
as
begin
	UPDATE int_organization 
                             SET 
                             organization_cd=@organizationCd,
                             organization_nm=@organizationNm 
                             WHERE 
                             organization_id=@organizationId
end
