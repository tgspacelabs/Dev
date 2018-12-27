

CREATE PROCEDURE [dbo].[p_cb_Load_History]
    (
     @TestCid INT,
     @ObsStartDt DATETIME,
     @PatientId UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
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
        [result_ft],
        [user_id],
        [user_role_id],
        [user_sid],
        [hcp_id],
        [login_name]
    FROM
        [dbo].[int_result]
        LEFT OUTER JOIN [dbo].[int_user] ON ([mod_user_id] = [user_id])
    WHERE
        [test_cid] = @TestCid
        AND [obs_start_dt] = @ObsStartDt
        AND [patient_id] = @PatientId
    ORDER BY
        [mod_dt] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_History';

