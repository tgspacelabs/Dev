CREATE PROCEDURE [dbo].[usp_DM3_UpdateActive_sw_EncounterId_in_PatientMonitor]
    (
     @MonitorID NVARCHAR(50), -- TG - should be BIGINT
     @PatientGUID NVARCHAR(50), -- TG - should be BIGINT
     @Connectdate NVARCHAR(50) = NULL, -- TG - should be DATETIME
     @EncounterIDGUID NVARCHAR(50) = NULL -- TG - should be BIGINT
    )
AS
BEGIN
    UPDATE
        [dbo].[int_patient_monitor]
    SET
        [active_sw] = 1,
        [encounter_id] = CAST(@EncounterIDGUID AS BIGINT)
    WHERE
        [monitor_id] = CAST(@MonitorID AS BIGINT)
        AND [patient_id] = CAST(@PatientGUID AS BIGINT)
        AND [monitor_connect_dt] = CAST(@Connectdate AS DATETIME);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateActive_sw_EncounterId_in_PatientMonitor';

