﻿CREATE PROCEDURE [dbo].[usp_DM3_AddPatientMonitor]
    (
     @PatientMonitorGUID NVARCHAR(50) = NULL, -- TG - should be BIGINT
     @PatientGUID NVARCHAR(50) = NULL, -- TG - should be BIGINT
     @MonitorID NVARCHAR(50) = NULL, -- TG - should be BIGINT
     @ConnectDate NVARCHAR(50) = NULL, -- TG - should be DATETIME
     @EncounterIDGUID NVARCHAR(50) = NULL -- TG - should be BIGINT
    )
AS
BEGIN
    INSERT  INTO [dbo].[int_patient_monitor]
            ([patient_monitor_id],
             [patient_id],
             [monitor_id],
             [monitor_interval],
             [poll_type],
             [monitor_connect_dt],
             [encounter_id],
             [active_sw]
            )
    VALUES
            (CAST(@PatientMonitorGUID AS BIGINT),
             CAST(@PatientGUID AS BIGINT),
             CAST(@MonitorID AS BIGINT),
             1,
             'P',
             CAST(@ConnectDate AS DATETIME),
             CAST(@EncounterIDGUID AS BIGINT),
             1
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Add or Update Encounter Table values in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_AddPatientMonitor';

