/* To get the patient details inserted from ADTA01*/

------FOR QRY - HL7 ---BEGIN

-- =============================================
-- Author:		Syam
-- Create date: Apr-16-2014
-- Description:	Retrieves the patient Id from given query item type (MRN, ACC, NODE ID or NODE NAME)
-- =============================================
CREATE FUNCTION [dbo].[fn_HL7_GetPatientIdFromQueryItemType] 
(
	-- Add the parameters for the function here
	@QueryItem NVARCHAR(80),
	@QueryType INT
)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
	
DECLARE @Patient_Id UNIQUEIDENTIFIER

IF(@QueryType = 0 )
BEGIN
SELECT @Patient_Id = PATIENTID FROM
	(SELECT map.patient_id AS PATIENTID
	FROM int_mrn_map MAP
	inner join int_patient_monitor AS PATMON ON PATMON.patient_id = MAP.patient_id
    inner join int_monitor AS MONITOR ON MONITOR.monitor_id = PATMON.monitor_id
	inner join int_product_access ACCESS  on ACCESS.organization_id = MONITOR.unit_org_id
	inner join int_organization ORG on ORG.organization_id = MONITOR.unit_org_id
	WHERE MAP.mrn_xid = @QueryItem 
	AND merge_cd = 'C' 	
	AND Access.product_cd='outHL7' 
	AND Org.category_cd = 'D'
	UNION
	SELECT  DLPAT.PATIENT_ID AS PATIENTID
	FROM v_PatientSessions DLPAT
	inner join int_product_access Access  on Access.organization_id = DLPAT.UNIT_ID
	inner join int_organization ORG on ORG.organization_id = DLPAT.UNIT_ID
	WHERE DLPAT.MRN_ID = @QueryItem
	AND Access.product_cd='outHL7' 
	AND Org.category_cd = 'D') AS PATIENTID
	
END

IF(@QueryType = 1)
BEGIN
	
	SELECT @Patient_Id = PATIENTID FROM	
	(SELECT MAP.patient_id AS PATIENTID
	FROM int_mrn_map MAP
	inner join int_patient_monitor AS PATMON ON PATMON.patient_id = MAP.patient_id
	inner join int_monitor AS MONITOR ON MONITOR.monitor_id = PATMON.monitor_id
	inner join int_product_access ACCESS ON ACCESS.organization_id = MONITOR.unit_org_id
	inner join int_organization ORG ON ORG.organization_id = MONITOR.unit_org_id
	WHERE map.mrn_xid2 = @QueryItem
	AND merge_cd = 'C'
	AND Access.product_cd='outHL7' 
	AND Org.category_cd = 'D'
	UNION
	SELECT DLPAT.PATIENT_ID AS PATIENTID
    FROM v_PatientSessions DLPAT
    inner join int_product_access ACCESS ON ACCESS.organization_id = DLPAT.UNIT_ID
	inner join int_organization ORG ON ORG.organization_id = DLPAT.UNIT_ID 
	WHERE DLPAT.ACCOUNT_ID = @QueryItem	
	AND Access.product_cd='outHL7' 
	AND Org.category_cd = 'D') AS PATIENTID
			
END

IF(@QueryType = 2)
BEGIN
	SELECT @Patient_Id = PATIENTID from	
	(SELECT MAP.patient_id AS PATIENTID
    FROM int_mrn_map MAP
    inner join int_patient_monitor AS PATMON ON PATMON.patient_id = MAP.patient_id
    inner join int_monitor AS MONITOR ON MONITOR.monitor_id = PATMON.monitor_id
	inner join int_product_access ACCESS  on ACCESS.organization_id = MONITOR.unit_org_id
	inner join int_organization ORG on ORG.organization_id = MONITOR.unit_org_id
	WHERE MONITOR.node_id = @QueryItem 
	AND PATMON.active_sw = 1 
	AND merge_cd = 'C'
	AND ORG.organization_id = MONITOR.unit_org_id 
	AND ACCESS.product_cd='outHL7' 
	AND ORG.category_cd = 'D'
	UNION
	SELECT DLPAT.PATIENT_ID AS PATIENTID
    FROM v_PatientSessions DLPAT
	inner join int_product_access ACCESS  on ACCESS.organization_id = DLPAT.UNIT_ID
	inner join Devices AS DEV ON DEV.Id = DLPAT.PATIENT_MONITOR_ID
	inner join int_organization ORG on ORG.organization_id = DLPAT.UNIT_ID 
	WHERE DEV.Name = @QueryItem 
	AND STATUS = 'A'
	AND ACCESS.product_cd='outHL7' 
	AND ORG.category_cd = 'D') AS PATIENTID
	
	
END

IF(@QueryType = 3)
BEGIN
	SELECT @Patient_Id = PATIENTID from	
	(SELECT MAP.patient_id AS PATIENTID
    FROM int_mrn_map MAP
    inner join int_patient_monitor AS PATMON ON PATMON.patient_id = MAP.patient_id
    inner join int_monitor AS MONITOR ON MONITOR.monitor_id = PATMON.monitor_id
	inner join int_product_access ACCESS  on ACCESS.organization_id = MONITOR.unit_org_id
	inner join int_organization ORG on ORG.organization_id = MONITOR.unit_org_id 
	WHERE MONITOR.monitor_name = @QueryItem 
	AND PATMON.active_sw = 1 
	AND merge_cd = 'C'
	AND ORG.organization_id = MONITOR.unit_org_id 
	AND ACCESS.product_cd='outHL7' 
	AND ORG.category_cd = 'D'
	UNION
	SELECT DLPAT.PATIENT_ID AS PATIENTID
    FROM v_PatientSessions DLPAT
	inner join int_product_access ACCESS  on ACCESS.organization_id = DLPAT.UNIT_ID
	inner join Devices AS DEV ON DEV.Id = DLPAT.DeviceId
	inner join int_organization ORG on ORG.organization_id = DLPAT.UNIT_ID 
	WHERE DLPAT.BED = @QueryItem 
	AND STATUS = 'A'
	AND ACCESS.product_cd='outHL7' 
	AND ORG.category_cd = 'D') AS PATIENTID
	
END


RETURN @Patient_Id
END


