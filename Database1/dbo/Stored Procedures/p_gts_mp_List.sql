

CREATE PROCEDURE [dbo].[p_gts_mp_List]
AS
BEGIN
    SET NOCOUNT ON;

    SET DEADLOCK_PRIORITY LOW;

    SELECT
        [network_id],
        [node_id],
        [bed_id],
        [room],
        [monitor_name],
        [subnet],
        [mrn_xid],
        [mrn_xid2],
        [adt_adm_sw],
        [first_nm],
        [middle_nm],
        [last_nm],
        [admit_dt],
        [monitor_interval],
        [last_poll_dt],
        [last_result_dt],
        [last_episodic_dt],
        [last_outbound_dt],
        [monitor_status],
        [monitor_connect_dt]
    FROM
        [dbo].[int_patient_monitor]
        INNER JOIN [dbo].[int_monitor] ON ([int_patient_monitor].[monitor_id] = [int_monitor].[monitor_id])
        INNER JOIN [dbo].[int_person] ON ([int_patient_monitor].[patient_id] = [person_id])
        INNER JOIN [dbo].[int_encounter] ON ([int_patient_monitor].[patient_id] = [int_encounter].[patient_id])
        INNER JOIN [dbo].[int_mrn_map] ON ([int_patient_monitor].[patient_id] = [int_mrn_map].[patient_id])
    WHERE
        ([active_sw] = 1)
        AND ([merge_cd] = 'C')
    ORDER BY
        [node_id],
        [bed_id];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_gts_mp_List';

