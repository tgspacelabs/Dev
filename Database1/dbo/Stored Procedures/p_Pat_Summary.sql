

CREATE PROCEDURE [dbo].[p_Pat_Summary] (@mrn CHAR(30))
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @pat_id UNIQUEIDENTIFIER,
        @msg VARCHAR(120);

    SELECT
        @pat_id = [patient_id]
    FROM
        [dbo].[int_mrn_map]
    WHERE
        [mrn_xid] = @mrn;

    IF (@pat_id IS NULL)
        SELECT
            'Patient not found ....';
    ELSE
    BEGIN
        SELECT
            'PATIENT    ',
            [patient_id],
            [new_patient_id],
            [organ_donor_sw],
            [living_will_sw],
            [birth_order],
            [veteran_status_cid],
            [birth_place],
            [ssn],
            [mpi_ssn1],
            [mpi_ssn2],
            [mpi_ssn3],
            [mpi_ssn4],
            [driv_lic_no],
            [mpi_dl1],
            [mpi_dl2],
            [mpi_dl3],
            [mpi_dl4],
            [driv_lic_state_code],
            [dob],
            [death_dt],
            [nationality_cid],
            [citizenship_cid],
            [ethnic_group_cid],
            [race_cid],
            [gender_cid],
            [primary_language_cid],
            [marital_status_cid],
            [religion_cid],
            [monitor_interval],
            [height],
            [weight],
            [bsa]
        FROM
            [dbo].[int_patient]
        WHERE
            [patient_id] = @pat_id;

        SELECT
            [PATIENT_MON] = 'PATIENT_MON',
            [patient_monitor_id],
            [patient_id],
            [orig_patient_id],
            [monitor_id],
            [monitor_interval],
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
            [encounter_id],
            [live_until_dt],
            [active_sw]
        FROM
            [dbo].[int_patient_monitor]
        WHERE
            [patient_id] = @pat_id;

        SELECT
            [PERSON_NAME] = 'PERSON_NAME',
            [person_nm_id],
            [recognize_nm_cd],
            [seq_no],
            [orig_patient_id],
            [active_sw],
            [prefix],
            [first_nm],
            [middle_nm],
            [last_nm],
            [suffix],
            [degree],
            [mpi_lname_cons],
            [mpi_fname_cons],
            [mpi_mname_cons],
            [start_dt]
        FROM
            [dbo].[int_person_name]
        WHERE
            [person_nm_id] = @pat_id;

        SELECT
            [PERSON] = 'PERSON     ',
            [person_id],
            [new_patient_id],
            [first_nm],
            [middle_nm],
            [last_nm],
            [suffix],
            [tel_no],
            [line1_dsc],
            [line2_dsc],
            [line3_dsc],
            [city_nm],
            [state_code],
            [zip_code],
            [country_cid]
        FROM
            [dbo].[int_person]
        WHERE
            [person_id] = @pat_id;

        SELECT
            [MRN_MAP] = 'MRN_MAP    ',
            [organization_id],
            [mrn_xid],
            [patient_id],
            [orig_patient_id],
            [merge_cd],
            [prior_patient_id],
            [mrn_xid2],
            [adt_adm_sw]
        FROM
            [dbo].[int_mrn_map]
        WHERE
            [patient_id] = @pat_id;

        SELECT
            [ENCOUNTER] = 'ENCOUNTER  ',
            [encounter_id],
            [organization_id],
            [mod_dt],
            [patient_id],
            [orig_patient_id],
            [account_id],
            [status_cd],
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
            [comment]
        FROM
            [dbo].[int_encounter]
        WHERE
            [patient_id] = @pat_id;

        SELECT
            [ORDER_MAP] = 'ORDER_MAP  ',
            [order_id],
            [patient_id],
            [orig_patient_id],
            [organization_id],
            [sys_id],
            [order_xid],
            [type_cd],
            [seq_no]
        FROM
            [dbo].[int_order_map]
        WHERE
            [patient_id] = @pat_id;

        SELECT
            'ORDER' = 'ORDER      ',
            [encounter_id],
            [order_id],
            [patient_id],
            [orig_patient_id],
            [priority_cid],
            [status_cid],
            [univ_svc_cid],
            [order_person_id],
            [order_dt],
            [enter_id],
            [verif_id],
            [transcriber_id],
            [parent_order_id],
            [child_order_sw],
            [order_cntl_cid],
            [history_sw],
            [monitor_sw]
        FROM
            [dbo].[int_order]
        WHERE
            [patient_id] = @pat_id;

        SELECT
            [ORDER_LINE] = 'ORDER_LINE ',
            [order_id],
            [seq_no],
            [patient_id],
            [orig_patient_id],
            [status_cid],
            [prov_svc_cid],
            [univ_svc_cid],
            [transport_cid],
            [order_line_comment],
            [clin_info_comment],
            [reason_comment],
            [scheduled_dt],
            [observ_dt],
            [status_chg_dt]
        FROM
            [dbo].[int_order_line]
        WHERE
            [patient_id] = @pat_id;

        SET NOCOUNT OFF;

        SELECT
            [RESULT] = 'RESULT     ',
            [result_id],
            [patient_id],
            [orig_patient_id],
            [obs_start_dt],
            [order_id],
            [is_history],
            [monitor_sw],
            [univ_svc_cid],
            [test_cid],
            [history_seq],
            [test_sub_id],
            [order_line_seq_no],
            [test_result_seq_no],
            [result_dt],
            [value_type_cd],
            [specimen_id],
            [source_cid],
            [status_cid],
            [last_normal_dt],
            [probability],
            [obs_id],
            [prin_rslt_intpr_id],
            [asst_rslt_intpr_id],
            [tech_id],
            [trnscrbr_id],
            [result_units_cid],
            [reference_range_id],
            [abnormal_cd],
            [abnormal_nature_cd],
            [prov_svc_cid],
            [nsurv_tfr_ind],
            [result_value],
            [result_text],
            [result_comment],
            [has_history],
            [mod_dt],
            [mod_user_id],
            [Sequence],
            [result_ft]
        FROM
            [dbo].[int_result]
        WHERE
            [patient_id] = @pat_id;
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Pat_Summary';

