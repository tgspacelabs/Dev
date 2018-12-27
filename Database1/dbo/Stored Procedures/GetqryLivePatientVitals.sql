

CREATE PROCEDURE [dbo].[GetqryLivePatientVitals]
    (
     @patient_id AS UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        [VL].[patient_id] [PATID],
        [VL].[monitor_id] [MONITORID],
        [VL].[collect_dt] [COLLECTDATE],
        [VL].[vital_value] [VITALS],
        [VL].[vital_time] [VITALSTIME],
        [MRNMAP].[organization_id] [ORGID],
        [MRNMAP].[mrn_xid] [MRN]
    FROM
        [dbo].[int_vital_live_temp] [VL],
        [dbo].[int_mrn_map] [MRNMAP],
        [dbo].[int_patient_monitor] [PM]
    WHERE
        (@patient_id = '00000000-0000-0000-0000-000000000000'
        OR [VL].[patient_id] = @patient_id
        )
        AND [VL].[patient_id] = [MRNMAP].[patient_id]
        AND [MRNMAP].[merge_cd] = 'C'
        AND [PM].[patient_id] = [VL].[patient_id]
        AND [PM].[monitor_id] = [VL].[monitor_id]
        AND [VL].[createdDT] = (SELECT
                                    MAX([VL_SUBTAB].[createdDT])
                                FROM
                                    [dbo].[int_vital_live_temp] AS [VL_SUBTAB]
                                WHERE
                                    [VL_SUBTAB].[monitor_id] = [VL].[monitor_id]
                                    AND [VL_SUBTAB].[patient_id] = [VL].[patient_id]
                                    AND [VL_SUBTAB].[createdDT] > (GETDATE( ) - 0.002)
                               );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetqryLivePatientVitals';

