

/* CH Patient Settings purge */
CREATE PROCEDURE [dbo].[p_Purge_ch_Patient_Settings]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @PatientSettingsDataPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[cfgValuesPatient]
        WHERE
            [timestamp] < @PurgeDate
            AND [cfgValuesPatient].[patient_id] NOT IN (SELECT
                                                            [patient_id]
                                                        FROM
                                                            [dbo].[int_encounter]
                                                        WHERE
                                                            [discharge_dt] IS NULL);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @PatientSettingsDataPurged = @@ROWCOUNT;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'CH Patient Settings purge', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_ch_Patient_Settings';

