
/*usp_InsertOrganizationInformation used to inser the Hl7 out bound message*/
CREATE PROCEDURE [dbo].[usp_InsertOrganizationInformation]
(
	@organizationId UNIQUEIDENTIFIER,
	@categoryCd char(1)=null,
	@parentOrganizationId UNIQUEIDENTIFIER=null,
	@organizationCd NVARCHAR(180)=null,
	@organizationNm NVARCHAR(180)=null,
	@inDefaultSearch tinyint=null,
	@monitorDisableSw tinyint=null,
	@autoCollectInterval int=null,
	@outboundInterval int=null,
	@printerName varchar(255)=null,
	@alarmPrinterName varchar(255)=null
)
AS
BEGIN
INSERT INTO int_organization
(
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
)
VALUES
(
	@organizationId,
	@categoryCd,
	@parentOrganizationId,
	@organizationCd,
	@organizationNm,
	@inDefaultSearch,
	@monitorDisableSw,
	@autoCollectInterval,
	@outboundInterval,
	@printerName,
	@alarmPrinterName
)

END


