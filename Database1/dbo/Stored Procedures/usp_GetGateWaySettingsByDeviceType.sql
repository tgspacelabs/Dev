
CREATE PROCEDURE [dbo].[usp_GetGateWaySettingsByDeviceType]
    (
     @GatewayType NVARCHAR(10)
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ig].[gateway_id],
        [ig].[gateway_type],
        [ig].[network_id],
        [ig].[hostname],
        [ig].[enable_sw],
        [ig].[recv_app],
        [ig].[send_app],
        [ig].[reconnect_secs],
        [ig].[organization_id],
        [ig].[send_sys_id],
        [ig].[results_usid],
        [ig].[sleep_secs],
        [ig].[add_monitors_sw],
        [ig].[add_patients_sw],
        [ig].[add_results_sw],
        [ig].[debug_level],
        [ig].[unit_org_id],
        [ig].[patient_id_type],
        [ig].[auto_assign_id_sw],
        [ig].[new_mrn_format],
        [ig].[auto_chan_attach_sw],
        [ig].[live_vitals_sw],
        [ig].[live_waveform_size],
        [ig].[decnet_node],
        [ig].[node_name],
        [ig].[nodes_excluded],
        [ig].[nodes_included],
        [ig].[timemaster_sw],
        [ig].[waveform_size],
        [ig].[print_enabled_sw],
        [ig].[auto_record_alarm_sw],
        [ig].[collect_12_lead_sw],
        [ig].[print_auto_record_sw],
        [ig].[encryption_status]
    FROM
        [dbo].[int_gateway] AS [ig]
    WHERE
        [ig].[gateway_type] = @GatewayType
    ORDER BY
        [ig].[network_id];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetGateWaySettingsByDeviceType';

