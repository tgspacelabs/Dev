

CREATE PROCEDURE [dbo].[GetrecvSendAndOrderInfo]
    (
     @patient_id AS UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [recv_app] [RECVAPP],
        [send_app] [SENDAPP],
        [order_xid] [ORDERXID],
        [send_app] [SENDAPP],
        [univ_svc_cid] [ORDERSTATUS],
        [order_dt] [TRANSDATETIME]
    FROM
        [dbo].[int_gateway],
        [dbo].[int_patient_monitor],
        [dbo].[int_monitor],
        [dbo].[int_order_map],
        [dbo].[int_order]
    WHERE
        [int_patient_monitor].[patient_id] = @patient_id
        AND [int_patient_monitor].[monitor_id] = [int_monitor].[monitor_id]
           --AND int_patient_monitor.active_sw=1 
        AND [int_monitor].[network_id] = [int_gateway].[network_id]
        AND [gateway_type] <> 'S5N'
        AND [int_order].[order_id] = [int_order_map].[order_id]
        AND [int_patient_monitor].[patient_id] = [int_order].[patient_id]
        AND [sys_id] = [send_sys_id];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetrecvSendAndOrderInfo';

