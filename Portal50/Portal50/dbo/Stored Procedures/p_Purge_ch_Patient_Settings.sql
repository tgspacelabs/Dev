
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
        DELETE TOP (@FChunkSize) [dbo].[CfgValuesPatient]
        WHERE [timestamp] < @PurgeDate 
            AND [patient_id] NOT IN (
                SELECT patient_id 
                FROM dbo.int_encounter
                WHERE discharge_dt IS NULL);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

	IF (@RC <> 0)
    SET @PatientSettingsDataPurged = @@ROWCOUNT;
END
