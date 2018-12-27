

CREATE PROCEDURE [dbo].[p_cb_Load_Encounter]
    (
     @encounterID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_encounter].[encounter_id],
        [int_encounter].[organization_id],
        [mod_dt],
        [int_encounter].[patient_id],
        [int_encounter].[orig_patient_id],
        [int_encounter].[account_id],
        [publicity_cid],
        [diet_type_cid],
        [patient_class_cid],
        [protection_type_cid],
        [vip_sw],
        [isolation_type_cid],
        [security_type_cid],
        [patient_type_cid],
        [admit_hcp_id],
        [med_svc_cid],
        [referring_hcp_id],
        [unit_org_id],
        [attend_hcp_id],
        [primary_care_hcp_id],
        [fall_risk_type_cid],
        [begin_dt],
        [ambul_status_cid],
        [admit_dt],
        [baby_cd],
        [rm],
        [recurring_cd],
        [bed],
        [discharge_dt],
        [newborn_sw],
        [discharge_dispo_cid],
        [monitor_created],
        [comment],
        [encounter_xid],
        [int_encounter_map].[organization_id],
        [int_encounter_map].[encounter_id],
        [int_encounter_map].[patient_id],
        [seq_no],
        [int_encounter_map].[orig_patient_id],
        [event_cd],
        [int_encounter_map].[account_id],
        [hcp_id],
        [hcp_type_cid],
        [last_nm],
        [first_nm],
        [middle_nm],
        [degree],
        [verification_sw],
        [doctor_ins_no_id],
        [doctor_dea_no],
        [medicare_id],
        [medicaid_id],
        [int_organization].[organization_id],
        [category_cd],
        [parent_organization_id],
        [organization_cd],
        [organization_nm],
        [in_default_search],
        [monitor_disable_sw],
        [auto_collect_interval],
        [outbound_interval],
        [printer_name],
        [alarm_printer_name],
        [int_encounter].[status_cd] AS [ESC],
        [int_encounter_map].[status_cd] AS [EMSC],
        [organization_cd] AS [DEPARTMENT_CD]
    FROM
        [dbo].[int_encounter]
        LEFT OUTER JOIN [dbo].[int_hcp] ON ([attend_hcp_id] = [hcp_id])
        INNER JOIN [dbo].[int_encounter_map] ON ([int_encounter].[encounter_id] = [int_encounter_map].[encounter_id])
        INNER JOIN [dbo].[int_organization] ON ([unit_org_id] = [int_organization].[organization_id])
    WHERE
        ([int_encounter].[encounter_id] = @encounterID)
        AND ([int_encounter_map].[status_cd] IN ('C', 'S'));
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_Encounter';

