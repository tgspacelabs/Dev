
CREATE PROCEDURE [dbo].[p_cb_Load_Result_Header]
  (
  @patientID UNIQUEIDENTIFIER,
  @orderID   UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT int_hcp.last_nm,
           int_hcp.first_nm,
           int_hcp.middle_nm,
           int_hcp.degree,
           int_order_line.observ_dt,
           int_order_line.order_line_comment,
           int_order_line.clin_info_comment,
           int_order_line.reason_comment,
           int_order_line.status_cid AS ORDER_LINE_STATUS,
           int_order_line.scheduled_dt,
           int_order_line.status_chg_dt,
           int_specimen.source_cid,
           int_specimen.body_site_cid,
           int_order.status_cid AS ORDER_TABLE_STATUS,
           int_order.order_dt,
           int_order.history_sw,
           int_misc_code.short_dsc,
           int_misc_code.code,
           int_order.univ_svc_cid,
           int_order.encounter_id,
           order_xid
    FROM   int_order
           LEFT OUTER JOIN int_specimen
             ON ( int_order.order_id = int_specimen.order_id ) AND ( int_order.encounter_id = int_specimen.encounter_id ) AND ( int_order.univ_svc_cid = int_specimen.univ_svc_cid )
           LEFT OUTER JOIN int_order_map
             ON ( int_order.order_id = int_order_map.order_id )
           LEFT OUTER JOIN int_hcp
             ON ( int_order.order_person_id = int_hcp.hcp_id )
           RIGHT OUTER JOIN int_misc_code
             ON ( int_order.univ_svc_cid = int_misc_code.code_id )
           INNER JOIN int_order_line
             ON ( int_order.order_id = int_order_line.order_id ) AND ( int_order.patient_id = int_order_line.patient_id )
    WHERE  ( int_order.order_id = '{23EB1F4B-DDA8-46E4-9EE3-9F95EEC08ADF}' ) AND ( int_order.patient_id = '{9E2B2D4E-4676-41AE-B54B-96C3AABEBEEA}' )
  END

