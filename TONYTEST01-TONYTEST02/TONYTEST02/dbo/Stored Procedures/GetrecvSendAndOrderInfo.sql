
CREATE PROCEDURE [dbo].[GetrecvSendAndOrderInfo]
  (
  @patient_id AS UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT recv_app RECVAPP,
           send_app SENDAPP,
           order_xid ORDERXID,
           send_app SENDAPP,
           univ_svc_cid ORDERSTATUS,
           int_order.order_dt TRANSDATETIME
    FROM   int_gateway,
           int_patient_monitor,
           int_monitor,
           int_order_map,
           int_order
    WHERE  int_patient_monitor.patient_id = @patient_id AND int_patient_monitor.monitor_id = int_monitor.monitor_id
           --AND int_patient_monitor.active_sw=1 
           AND int_monitor.network_id = int_gateway.network_id AND int_gateway.gateway_type <> 'S5N' AND int_order.order_id = int_order_map.order_id AND int_patient_monitor.patient_id = int_order.patient_id AND int_order_map.sys_id = int_gateway.send_sys_id
  END


