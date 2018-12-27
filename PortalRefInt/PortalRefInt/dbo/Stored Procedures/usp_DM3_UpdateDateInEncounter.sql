CREATE PROCEDURE [dbo].[usp_DM3_UpdateDateInEncounter]
    (
     @MonitorId NVARCHAR(50) = NULL, -- TG - should be BIGINT
     @EncounterId NVARCHAR(50) = NULL -- TG - should be BIGINT
    )
AS
BEGIN
    UPDATE
        [dbo].[int_encounter]
    SET
        [discharge_dt] = GETDATE(),
        [status_cd] = N'D'
    WHERE
        [status_cd] = N'C'
        AND [encounter_id] IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_patient_monitor]
                               WHERE
                                [monitor_id] = CAST(@MonitorId AS BIGINT)
                                AND [encounter_id] <> CAST(@EncounterId AS BIGINT));
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Update MonitorId and EncounterId in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateDateInEncounter';

