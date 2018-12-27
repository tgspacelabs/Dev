

CREATE PROCEDURE [dbo].[p_On_Monitor]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_patient_monitor].[patient_id],
        [MRN] = CONVERT (CHAR(10), [mrn_xid]),
        [MONITOR] = [monitor_name],
        "LAST NAME" = CONVERT (CHAR(15), [last_nm]),
        "FIRST NAME" = CONVERT(CHAR(15), [first_nm]),
        [INTERVAL] = [monitor_interval],
        [poll_start_dt],
        [poll_end_dt],
        [monitor_status],
        [monitor_error]
    FROM
        [dbo].[int_mrn_map],
        [dbo].[int_person_name],
        [dbo].[int_patient_monitor],
        [dbo].[int_monitor]
    WHERE
        [int_mrn_map].[patient_id] = [person_nm_id]
        AND [int_patient_monitor].[patient_id] = [int_mrn_map].[patient_id]
        AND [int_patient_monitor].[monitor_id] = [int_monitor].[monitor_id];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_On_Monitor';

