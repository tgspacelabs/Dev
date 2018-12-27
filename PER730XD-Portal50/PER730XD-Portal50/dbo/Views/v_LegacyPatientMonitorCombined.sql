﻿

CREATE VIEW [dbo].[v_LegacyPatientMonitorCombined]
AS
SELECT  
      PatientId as [patient_monitor_id]
      ,PatientId as [patient_id]
      ,NULL as [orig_patient_id]
      ,DeviceId as [monitor_id]
      ,'1' as [monitor_interval]
      ,'P' as [poll_type]
      ,SessionStartTimeUTC as [monitor_connect_dt]
      ,NULL as [monitor_connect_num]
      ,NULL as [disable_sw]
      ,GETDATE() as [last_poll_dt]
      ,GETDATE() as [last_result_dt]
      ,GETDATE() as [last_episodic_dt]
      ,NULL as [poll_start_dt]
      ,NULL as [poll_end_dt]
      ,NULL as [last_outbound_dt]
      ,NULL as [monitor_status]
      ,NULL as [monitor_error]
      ,EncounterId as [encounter_id]
      ,NULL as [live_until_dt]
      ,'1' as [active_sw]
FROM  [dbo].[v_LegacyPatientMonitor]

Union ALL 

SELECT [patient_monitor_id]
      ,[patient_id]
      ,[orig_patient_id]
      ,[monitor_id]
      ,[monitor_interval]
      ,[poll_type]
      ,[monitor_connect_dt]
      ,[monitor_connect_num]
      ,[disable_sw]
      ,[last_poll_dt]
      ,[last_result_dt]
      ,[last_episodic_dt]
      ,[poll_start_dt]
      ,[poll_end_dt]
      ,[last_outbound_dt]
      ,[monitor_status]
      ,[monitor_error]
      ,[encounter_id]
      ,[live_until_dt]
      ,[active_sw]
  FROM [dbo].[int_patient_monitor]
