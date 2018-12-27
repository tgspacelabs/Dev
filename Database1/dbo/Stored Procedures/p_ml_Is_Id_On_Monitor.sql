

CREATE PROCEDURE [dbo].[p_ml_Is_Id_On_Monitor]
    (
     @PatId AS VARCHAR(20),
     @CurrentMonitor AS VARCHAR(10) = ''
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF @CurrentMonitor IS NULL
        SET @CurrentMonitor = '';

    SELECT
        [active_sw],
        [monitor_name],
        [standby]
    FROM
        [dbo].[int_mrn_map]
        LEFT OUTER JOIN [dbo].[int_patient_monitor] ON ([int_mrn_map].[patient_id] = [int_patient_monitor].[patient_id]
                                                   AND [active_sw] = '1'
                                                   )
        LEFT OUTER JOIN [dbo].[int_monitor] ON ([int_patient_monitor].[monitor_id] = [int_monitor].[monitor_id])
    WHERE
        [mrn_xid] = @PatId
        AND [monitor_name] <> @CurrentMonitor
        AND [active_sw] = '1'
        AND [merge_cd] = 'C'
        AND [standby] IS NULL
    UNION
    SELECT TOP 1
        [active_sw] = '1',
        'ET' AS [monitor_name],
        [standby] = NULL
    FROM
        [dbo].[int_mrn_map]
        INNER JOIN [dbo].[v_PatientTopicSessions] ON [PatientId] = [patient_id]
        INNER JOIN [dbo].[TopicSessions] ON [Id] = [TopicSessionId]
    WHERE
        [mrn_xid] = @PatId
        AND [EndTimeUTC] IS NULL;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_ml_Is_Id_On_Monitor';

