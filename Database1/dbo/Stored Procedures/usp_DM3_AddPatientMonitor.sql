
-- [AddPatientMonitor_Dm3] is used to Add or Update Encounter Table values in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_AddPatientMonitor]
    (
     @PatientMonitorGUID NVARCHAR(50) = NULL,
     @PatientGUID NVARCHAR(50) = NULL,
     @MonitorID NVARCHAR(50) = NULL,
     @Connectdate NVARCHAR(50) = NULL,
     @EncounterIDGUID NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

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
            (@PatientMonitorGUID,
             @PatientGUID,
             @MonitorID,
             1,
             'P',
             @Connectdate,
             @EncounterIDGUID,
             '1'
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Add or Update Encounter Table values in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_AddPatientMonitor';

