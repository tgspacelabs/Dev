

CREATE PROCEDURE [dbo].[p_cb_Load_Monitor_Patient_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [PR].[person_id],
        [PR].[last_nm],
        [PR].[first_nm],
        [PR].[middle_nm],
        [PR].[suffix],
        [PT].[gender_cid],
        [PT].[dob],
        [O2].[organization_cd] [DEPARTMENT_CD],
        [E].[rm],
        [E].[bed],
        [E].[med_svc_cid],
        [PM].[patient_monitor_id],
        [PM].[patient_id],
        [PM].[orig_patient_id],
        [PM].[monitor_id],
        [PM].[monitor_interval],
        [PM].[poll_type],
        [PM].[monitor_connect_dt],
        [PM].[monitor_connect_num],
        [PM].[disable_sw],
        [PM].[last_poll_dt],
        [PM].[last_result_dt],
        [PM].[last_episodic_dt],
        [PM].[poll_start_dt],
        [PM].[poll_end_dt],
        [PM].[last_outbound_dt],
        [PM].[monitor_status],
        [PM].[monitor_error],
        [PM].[encounter_id],
        [PM].[live_until_dt],
        [PM].[active_sw],
        [M].[mrn_xid],
        [E].[vip_sw],
        [E].[admit_dt],
        [E].[discharge_dt],
        [E].[begin_dt],
        [E].[encounter_id],
        [E].[status_cd],
        [E].[patient_class_cid],
        [E].[patient_type_cid],
        [O1].[organization_cd],
        [O1].[organization_nm],
        [int_hcp].[last_nm] [HCP_LNAME],
        [int_hcp].[first_nm] [HCP_FNAME],
        [E].[organization_id]
    FROM
        [dbo].[int_patient] [PT]
        LEFT JOIN [dbo].[int_mrn_map] [M] ON [PT].[patient_id] = [M].[patient_id]
        LEFT JOIN [dbo].[int_person] [PR] ON [PT].[patient_id] = [PR].[person_id]
        LEFT JOIN [dbo].[int_encounter] [E] ON [PT].[patient_id] = [E].[patient_id]
        LEFT JOIN [dbo].[int_hcp] ON [hcp_id] = [E].[attend_hcp_id]
        LEFT JOIN [dbo].[int_organization] [O1] ON [O1].[organization_id] = [E].[organization_id]
        LEFT JOIN [dbo].[int_organization] [O2] ON [O2].[organization_id] = [E].[unit_org_id]
        LEFT JOIN [dbo].[int_patient_monitor] [PM] ON [PM].[encounter_id] = [E].[encounter_id]
                                            AND [PM].[patient_id] = [PT].[patient_id]
    WHERE
        [M].[merge_cd] = 'C'
        AND [PM].[active_sw] = 1;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_Monitor_Patient_List';

