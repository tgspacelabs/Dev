
/*usp_GetOrganizationInformation will fetch the organization details based on the Organization code or Category Code */
CREATE PROCEDURE usp_GetOrganizationInformation
(
@organizationCd NVARCHAR(40)=null,
@categoryCd char=null
)
AS
BEGIN
      SET NOCOUNT ON;
      IF(@organizationCd IS NOT NULL AND @categoryCd IS NOT NULL)
      BEGIN
      SELECT 
		organization_id,
		category_cd,
		parent_organization_id,
		organization_cd,
		organization_nm,
		in_default_search,
		monitor_disable_sw,
		auto_collect_interval,
		outbound_interval,
		printer_name,
		alarm_printer_name
		FROM int_organization 
		WHERE category_cd=@categoryCd 
		AND organization_cd=@organizationCd
	  END
    ELSE IF(@categoryCd IS NOT NULL)
    BEGIN
		SELECT 
		organization_id,
		category_cd,
		parent_organization_id,
		organization_cd,
		organization_nm,
		in_default_search,
		monitor_disable_sw,
		auto_collect_interval,
		outbound_interval,
		printer_name,
		alarm_printer_name
		FROM int_organization 
		WHERE category_cd=@categoryCd
	END	
	SET NOCOUNT OFF;
END
