
CREATE PROCEDURE [dbo].[GetPatientData]
    (
     @PatientID DPATIENT_ID
    )
AS
BEGIN
    --SET NOCOUNT ON;

    SELECT
        CONCAT([ipe].[last_nm], ', ', [ipe].[first_nm]) AS [PATIENT_NAME],
        [monitor_name] AS [MONITOR_NAME],
        [imm].[mrn_xid2] AS [ACCOUNT_ID],
        [imm].[mrn_xid] AS [MRN_ID],
        [int_monitor].[unit_org_id] AS [UNIT_ID],
        [CHILD].[organization_cd] AS [UNIT_NAME],
        [PARENT].[organization_id] AS [FACILITY_ID],
        [PARENT].[organization_nm] AS [FACILITY_NAME],
        [ipa].[dob] AS [DOB],
        [ie].[admit_dt] AS [ADMIT_TIME],
        [ie].[discharge_dt] AS [DISCHARGED_TIME],
        [ipm].[patient_monitor_id] AS [PATIENT_MONITOR_ID],
        CASE WHEN [ie].[discharge_dt] IS NULL THEN 'A'
             ELSE 'D'
        END AS [STATUS],
        [ipm].[last_result_dt] AS [PRECEDENCE]
    FROM
        [dbo].[int_mrn_map] AS [imm]
        INNER JOIN [dbo].[int_patient] AS [ipa] ON [ipa].[patient_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_person] AS [ipe] ON [ipe].[person_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_encounter] AS [ie] ON [ie].[patient_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [ipm] ON [ie].[encounter_id] = [ipm].[encounter_id]
        INNER JOIN [dbo].[int_monitor] ON [ipm].[monitor_id] = [int_monitor].[monitor_id]
        INNER JOIN [dbo].[int_organization] AS [CHILD] ON [int_monitor].[unit_org_id] = [CHILD].[organization_id]
        LEFT OUTER JOIN [dbo].[int_organization] AS [PARENT] ON [PARENT].[organization_id] = [CHILD].[parent_organization_id]
    WHERE
        [imm].[patient_id] = @PatientID
        AND [imm].[merge_cd] = 'C'
    UNION
    SELECT
        [vsp].[PATIENT_NAME],
        [vsp].[MONITOR_NAME],
        [vsp].[ACCOUNT_ID],
        [vsp].[MRN_ID],
        [vsp].[UNIT_ID],
        [vsp].[UNIT_NAME],
        [vsp].[FACILITY_ID],
        [vsp].[FACILITY_NAME],
        [vsp].[DOB],
        [vsp].[ADMIT_TIME],
        [vsp].[DISCHARGED_TIME],
        [vsp].[PATIENT_MONITOR_ID],
        [vsp].[STATUS],
        [vsp].[ADMIT_TIME] AS [PRECEDENCE]
    FROM
        [dbo].[v_StitchedPatients] AS [vsp]
    WHERE
        [vsp].[PATIENT_ID] = @PatientID
    ORDER BY
        [PRECEDENCE] DESC; 
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientData';

