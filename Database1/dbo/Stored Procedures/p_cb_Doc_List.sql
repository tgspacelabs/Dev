﻿

CREATE PROCEDURE [dbo].[p_cb_Doc_List]
    (
     @HCPId UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [person_id],
        [int_person].[last_nm],
        [int_person].[first_nm],
        [int_person].[middle_nm],
        [suffix],
        [gender_cid],
        [dob],
        [O2].[organization_cd] [DEPARTMENT_CD],
        [rm],
        [bed],
        [med_svc_cid],
        [mrn_xid],
        [vip_sw],
        [admit_dt],
        [discharge_dt],
        [begin_dt],
        [int_encounter].[encounter_id],
        [status_cd],
        [patient_class_cid],
        [patient_type_cid],
        [O1].[organization_cd],
        [O1].[organization_nm],
        [int_hcp].[last_nm] [HCP_LNAME],
        [int_hcp].[first_nm] [HCP_FNAME],
        [int_encounter].[organization_id],
        [int_patient_list_detail].[patient_list_id],
        [new_results],
        [viewed_results_dt],
        0 [TRANS],
        [patient_monitor_id],
        [int_patient_monitor].[patient_id],
        [int_patient_monitor].[orig_patient_id],
        [monitor_id],
        [int_patient_monitor].[monitor_interval],
        [poll_type],
        [monitor_connect_dt],
        [monitor_connect_num],
        [disable_sw],
        [last_poll_dt],
        [last_result_dt],
        [last_episodic_dt],
        [poll_start_dt],
        [poll_end_dt],
        [last_outbound_dt],
        [monitor_status],
        [monitor_error],
        [int_patient_monitor].[encounter_id],
        [live_until_dt],
        [active_sw]
    FROM
        [dbo].[int_encounter]
        LEFT OUTER JOIN [dbo].[int_hcp] ON ([attend_hcp_id] = [hcp_id])
        LEFT OUTER JOIN [dbo].[int_organization] [O1] ON ([int_encounter].[organization_id] = [O1].[organization_id])
        LEFT OUTER JOIN [dbo].[int_organization] [O2] ON ([unit_org_id] = [O2].[organization_id])
        LEFT OUTER JOIN [dbo].[int_patient_monitor] ON ([int_encounter].[encounter_id] = [int_patient_monitor].[encounter_id])
                                               AND ([int_encounter].[patient_id] = [int_patient_monitor].[patient_id])
        INNER JOIN [dbo].[int_patient_list_detail] ON ([int_encounter].[encounter_id] = [int_patient_list_detail].[encounter_id])
        INNER JOIN [dbo].[int_mrn_map] ON ([int_patient_list_detail].[patient_id] = [int_mrn_map].[patient_id])
        INNER JOIN [dbo].[int_person] ON ([int_patient_list_detail].[patient_id] = [person_id])
        INNER JOIN [dbo].[int_patient] ON ([person_id] = [int_patient].[patient_id])
        INNER JOIN [dbo].[int_patient_list] ON ([int_patient_list].[patient_list_id] = [int_patient_list_detail].[patient_list_id])
    WHERE
        ([owner_id] = @HCPId)
        AND ([owner_id] IS NOT NULL)
        AND ([type_cd] <> 'P')
        AND ([merge_cd] = 'C')
        AND ([deleted] = 0);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Doc_List';
