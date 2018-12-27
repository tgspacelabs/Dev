
CREATE PROCEDURE [p_ml_Is_Id_On_Monitor]
  (
  @PatId          AS VARCHAR(20),
  @CurrentMonitor AS VARCHAR(10) = ''
  )
AS
  BEGIN
    IF @CurrentMonitor IS NULL
      SET @CurrentMonitor = '';

    SELECT dbo.int_patient_monitor.active_sw,
           dbo.int_monitor.monitor_name,
           dbo.int_monitor.standby           
    FROM   dbo.int_mrn_map
           LEFT OUTER JOIN dbo.int_patient_monitor
             ON ( int_mrn_map.patient_id = dbo.int_patient_monitor.patient_id AND active_sw = '1' )
           LEFT OUTER JOIN dbo.int_monitor
             ON ( dbo.int_patient_monitor.monitor_id = dbo.int_monitor.monitor_id )
    WHERE  mrn_xid = @PatID AND int_monitor.monitor_name <> @CurrentMonitor AND active_sw = '1' AND merge_cd = 'C'

UNION 

    SELECT TOP 1 [active_sw] = '1',
           'ET' AS [monitor_name],
           [standby] = NULL
        FROM [dbo].[int_mrn_map]
        INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[PatientId]=[int_mrn_map].[patient_id]
        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id]=[v_PatientTopicSessions].[TopicSessionId]
        WHERE [int_mrn_map].[mrn_xid]=@PatId AND [TopicSessions].[EndTimeUTC] IS NULL
  END

