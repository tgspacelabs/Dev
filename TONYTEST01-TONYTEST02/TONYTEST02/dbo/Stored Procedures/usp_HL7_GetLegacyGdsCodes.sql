
-- =============================================
-- Author:		SyamB
-- Create date: 16-05-2014
-- Description:	Retrieves the legacy Gds codes
-- =============================================
CREATE PROCEDURE [dbo].[usp_HL7_GetLegacyGdsCodes]
AS
BEGIN
	
	SELECT
	code_id AS CodeId,
	code AS Gds_Code,
	short_dsc AS Gds_Description,
	int_keystone_cd AS Gds_UoM
	FROM int_misc_code
	
END


