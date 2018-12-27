
--DM3 Procedures

-- [UpdateDateInEncounter] is used to Update MonitorId and EncounterId in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_UpdateDateInEncounter]
    (
     @MonitorId NVARCHAR(50) = NULL,
     @EncounterId NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_encounter]
    SET
        [discharge_dt] = GETDATE(),
        [status_cd] = 'D'
    WHERE
        [status_cd] = 'C'
        AND [int_encounter].[encounter_id] IN (SELECT
                                                [encounter_id]
                                             FROM
                                                [dbo].[int_patient_monitor]
                                             WHERE
                                                [monitor_id] = @MonitorId
                                                AND [encounter_id] <> @EncounterId);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Update MonitorId and EncounterId in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateDateInEncounter';

