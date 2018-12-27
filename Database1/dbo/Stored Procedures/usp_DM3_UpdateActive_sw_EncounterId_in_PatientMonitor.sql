

CREATE PROCEDURE [dbo].[usp_DM3_UpdateActive_sw_EncounterId_in_PatientMonitor]
    (
     @MonitorID NVARCHAR(50),
     @PatientGUID NVARCHAR(50),
     @Connectdate NVARCHAR(50) = NULL,
     @EncounterIDGUID NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_patient_monitor]
    SET
        [active_sw] = 1,
        [encounter_id] = @EncounterIDGUID
    WHERE
        [monitor_id] = @MonitorID
        AND [patient_id] = @PatientGUID
        AND [monitor_connect_dt] = @Connectdate;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateActive_sw_EncounterId_in_PatientMonitor';

