CREATE PROCEDURE [dbo].[GetUserPatientsList]
    (
     @unit_id DUNIT_ID,
     @status NVARCHAR(40),
     @is_vip_searchable BIT = '0',
     @Debug BIT = 0
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @QUERY NVARCHAR(4000),
        @ParmDefinition NVARCHAR(200) = '@unit_id UNIQUEIDENTIFIER';

    SET @QUERY = N'
    SELECT imm.patient_id AS PATIENT_ID,
        CONCAT(per.last_nm, N'', '', per.first_nm) AS PATIENT_NAME,
        im.monitor_name AS MONITOR_NAME,
        imm.mrn_xid2 AS ACCOUNT_ID,
        imm.mrn_xid AS MRN_ID,
        im.unit_org_id AS UNIT_ID,
        child.organization_cd AS UNIT_NAME,
        parent.organization_id AS FACILITY_ID,
        parent.organization_nm AS FACILITY_NAME,  
        ip.dob AS DOB,
        ie.admit_dt AS ADMIT_TIME,
        ie.discharge_dt AS DISCHARGED_TIME,
        ipm.patient_monitor_id AS PATIENT_MONITOR_ID,
        STATUS = CASE
            WHEN ie.discharge_dt IS NULL AND active_sw = 1 THEN ''A'' 
            ELSE ''D''
        END
    FROM dbo.int_encounter AS ie
        LEFT OUTER JOIN dbo.int_patient_monitor AS ipm ON ie.encounter_id = ipm.encounter_id 
            AND ie.patient_id = ipm.patient_id
        INNER JOIN dbo.int_person AS per ON ie.patient_id = per.person_id
        INNER JOIN dbo.int_patient AS ip ON per.person_id = ip.patient_id
        INNER JOIN dbo.int_mrn_map AS imm ON ip.patient_id = imm.patient_id
        INNER JOIN dbo.int_monitor AS im ON ipm.monitor_id = im.monitor_id
        INNER JOIN dbo.int_organization AS child ON im.unit_org_id = child.organization_id 
        LEFT OUTER JOIN dbo.int_organization AS parent ON parent.organization_id = child.parent_organization_id                                        
    WHERE im.unit_org_id = @unit_id 
        AND imm.merge_cd = ''C''';

    IF (@status = N'ACTIVE')
        SET @QUERY += N' AND ie.discharge_dt IS NULL 
        AND ipm.active_sw = 1';

    IF (@status = N'DISCHARGED')
        SET @QUERY += N' AND ie.discharge_dt IS NOT NULL';

    IF (@is_vip_searchable <> '1')
        SET @QUERY += N' AND ie.vip_sw IS NULL';

    SET @QUERY += N'
    UNION
    SELECT
        [PATIENT_ID],
        [PATIENT_NAME],
        [MONITOR_NAME],
        [ACCOUNT_ID],
        [MRN_ID],
        [UNIT_ID],
        [UNIT_NAME],
        [FACILITY_ID],
        [FACILITY_NAME],
        [DOB],
        [ADMIT_TIME],
        [DISCHARGED_TIME],
        [PATIENT_MONITOR_ID],
        [STATUS]
    FROM [dbo].[v_StitchedPatients] 
    WHERE [UNIT_ID] = @unit_id';

    IF (@status = N'ACTIVE')
        SET @QUERY += N' AND [STATUS] = ''A''';

    IF (@status = N'DISCHARGED')
        SET @QUERY += N' AND [STATUS] = ''D''';

    SET @QUERY += N' AND [PATIENT_ID] IS NOT NULL
    ORDER BY [ADMIT_TIME] DESC,
        [PATIENT_NAME],
        [MONITOR_NAME]';

    IF (@Debug = 1)
        PRINT @QUERY;

    EXEC [sys].[sp_executesql] @QUERY, @ParmDefinition, @unit_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetUserPatientsList';

