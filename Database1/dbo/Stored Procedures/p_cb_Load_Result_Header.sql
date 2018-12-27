

CREATE PROCEDURE [dbo].[p_cb_Load_Result_Header]
    (
     @patientID UNIQUEIDENTIFIER,
     @orderID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [last_nm],
        [first_nm],
        [middle_nm],
        [degree],
        [observ_dt],
        [order_line_comment],
        [clin_info_comment],
        [reason_comment],
        [int_order_line].[status_cid] AS [ORDER_LINE_STATUS],
        [scheduled_dt],
        [status_chg_dt],
        [source_cid],
        [body_site_cid],
        [int_order].[status_cid] AS [ORDER_TABLE_STATUS],
        [order_dt],
        [history_sw],
        [short_dsc],
        [code],
        [int_order].[univ_svc_cid],
        [int_order].[encounter_id],
        [order_xid]
    FROM
        [dbo].[int_order]
        LEFT OUTER JOIN [dbo].[int_specimen] ON ([int_order].[order_id] = [int_specimen].[order_id])
                                        AND ([int_order].[encounter_id] = [int_specimen].[encounter_id])
                                        AND ([int_order].[univ_svc_cid] = [int_specimen].[univ_svc_cid])
        LEFT OUTER JOIN [dbo].[int_order_map] ON ([int_order].[order_id] = [int_order_map].[order_id])
        LEFT OUTER JOIN [dbo].[int_hcp] ON ([order_person_id] = [hcp_id])
        RIGHT OUTER JOIN [dbo].[int_misc_code] ON ([int_order].[univ_svc_cid] = [code_id])
        INNER JOIN [dbo].[int_order_line] ON ([int_order].[order_id] = [int_order_line].[order_id])
                                     AND ([int_order].[patient_id] = [int_order_line].[patient_id])
    WHERE
        ([int_order].[order_id] = '{23EB1F4B-DDA8-46E4-9EE3-9F95EEC08ADF}')
        AND ([int_order].[patient_id] = '{9E2B2D4E-4676-41AE-B54B-96C3AABEBEEA}');
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_Result_Header';

