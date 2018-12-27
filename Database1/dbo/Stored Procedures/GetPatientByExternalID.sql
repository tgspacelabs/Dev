

CREATE PROCEDURE [dbo].[GetPatientByExternalID]
    (
     @patientExtID AS NVARCHAR(30)
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_mrn_map].[patient_id] AS [PATIENT_ID],
        [mrn_xid] AS [PATIENT_MRN],
        [first_nm] AS [FIRST_NAME],
        [last_nm] AS [LAST_NAME]
    FROM
        [dbo].[int_mrn_map]
        INNER JOIN [dbo].[int_encounter] ON [int_encounter].[patient_id] = [int_mrn_map].[patient_id]
        INNER JOIN [dbo].[int_person] ON [int_encounter].[patient_id] = [person_id]
        INNER JOIN [dbo].[int_patient] ON [int_encounter].[patient_id] = [int_patient].[patient_id]
        INNER JOIN [dbo].[int_patient_monitor] ON [int_patient_monitor].[encounter_id] = [int_encounter].[encounter_id]
        INNER JOIN [dbo].[int_monitor] ON [int_monitor].[monitor_id] = [int_patient_monitor].[monitor_id]
    WHERE
        RTRIM(LTRIM([mrn_xid])) = RTRIM(LTRIM(@patientExtID))
        AND [merge_cd] = 'C' -- first return patients matching ID1
    UNION ALL
    SELECT
        [PATIENT_ID],
        [ID1] AS [PATIENT_MRN],
        [FIRST_NAME],
        [LAST_NAME]
    FROM
        [dbo].[v_Patients]
    WHERE
        [ID1] = @patientExtID -- first return patients matching ID1
    UNION ALL
    SELECT
        [int_mrn_map].[patient_id] AS [PATIENT_ID],
        [mrn_xid] AS [PATIENT_MRN],
        [first_nm] AS [FIRST_NAME],
        [last_nm] AS [LAST_NAME]
    FROM
        [dbo].[int_mrn_map]
        INNER JOIN [dbo].[int_encounter] ON [int_encounter].[patient_id] = [int_mrn_map].[patient_id]
        INNER JOIN [dbo].[int_person] ON [int_encounter].[patient_id] = [person_id]
        INNER JOIN [dbo].[int_patient] ON [int_encounter].[patient_id] = [int_patient].[patient_id]
        INNER JOIN [dbo].[int_patient_monitor] ON [int_patient_monitor].[encounter_id] = [int_encounter].[encounter_id]
        INNER JOIN [dbo].[int_monitor] ON [int_monitor].[monitor_id] = [int_patient_monitor].[monitor_id]
    WHERE
        RTRIM(LTRIM([mrn_xid2])) = RTRIM(LTRIM(@patientExtID))
        AND [merge_cd] = 'C' -- then return patients matching ID2
    UNION ALL
    SELECT
        [PATIENT_ID],
        [ID1] AS [PATIENT_MRN],
        [FIRST_NAME],
        [LAST_NAME]
    FROM
        [dbo].[v_Patients]
    WHERE
        [ID2] = @patientExtID; -- then return patients matching ID2
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientByExternalID';

