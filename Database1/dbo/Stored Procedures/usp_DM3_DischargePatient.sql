

CREATE PROCEDURE [dbo].[usp_DM3_DischargePatient]
    (
     @DischargeDate NVARCHAR(50) = NULL,
     @EncounterIDGUID NVARCHAR(50) = NULL,
     @MonitorID NVARCHAR(50)
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF (@DischargeDate = 'NULL')
    BEGIN	
        SET @DischargeDate = GETDATE(); 
    END;

    UPDATE
        [dbo].[int_encounter]
    SET
        [discharge_dt] = @DischargeDate,
        [status_cd] = 'D'
    WHERE
        [encounter_id] = @EncounterIDGUID;

    UPDATE
        [dbo].[int_patient_monitor]
    SET
        [active_sw] = NULL
    WHERE
        [monitor_id] = @MonitorID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_DischargePatient';

