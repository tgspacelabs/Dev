
CREATE PROCEDURE [dbo].[p_Purge_Encounter_Data]
(
    @FChunkSize INT,
    @EncounterDataPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;

    -- Delete Encounter first as the root, then delete other leaves
    DELETE [dbo].[int_encounter_map]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_diagnosis]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_diagnosis_drg]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_guarantor]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_order]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE FROM [dbo].[int_order_map]
    WHERE order_id NOT IN (SELECT order_id
                            FROM [dbo].[int_order]);

    SET @RC += @@ROWCOUNT;

    DELETE FROM [dbo].[int_order_line]
    WHERE order_id NOT IN (SELECT order_id
                            FROM [dbo].[int_order])

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_patient_list_detail]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_encounter_to_hcp_int]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_encounter_tfr_history]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_patient_monitor]
    WHERE encounter_id NOT IN (SELECT encounter_id
                                FROM [dbo].[int_encounter]) 
        AND ISNULL(active_sw, 0) <> 1;

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_account]
    WHERE account_id NOT IN (SELECT account_id
                                FROM [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE TOP (@FChunkSize) [dbo].[int_patient_channel]
    WHERE [patient_id] IN
	(
		SELECT [PatientId]
			FROM [dbo].[v_PatientDaysSinceLastDischarge]
			WHERE [DaysSinceLastDischarge] >= 10
	)

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_person]
    WHERE [person_id] IN
	(
		SELECT [PatientId]
			FROM [dbo].[v_PatientDaysSinceLastDischarge]
			WHERE [DaysSinceLastDischarge] >= 10
	)

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_patient]
    WHERE [patient_id] IN
	(
		SELECT [PatientId]
			FROM [dbo].[v_PatientDaysSinceLastDischarge]
			WHERE [DaysSinceLastDischarge] >= 10
	)

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_person_name]
    WHERE [person_nm_id] IN
	(
		SELECT [PatientId]
			FROM [dbo].[v_PatientDaysSinceLastDischarge]
			WHERE [DaysSinceLastDischarge] >= 10
	)

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_mrn_map]
    WHERE [patient_id] IN
	(
		SELECT [PatientId]
			FROM [dbo].[v_PatientDaysSinceLastDischarge]
			WHERE [DaysSinceLastDischarge] >= 10
	)

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_encounter]
    WHERE  encounter_id IN
           ( SELECT encounter_id
             FROM   [dbo].[int_encounter]
			 WHERE [patient_id] IN
			 (
			  	SELECT [PatientId]
					FROM [dbo].[v_PatientDaysSinceLastDischarge]
					WHERE [DaysSinceLastDischarge] >= 10
			 )
           )

    SET @RC += @@ROWCOUNT;

    DELETE [dbo].[int_encounter]
    WHERE encounter_id NOT IN ( 
        SELECT encounter_id
        FROM [dbo].[int_encounter]
		WHERE [patient_id] IN (
		    SELECT [PatientId] FROM [dbo].[v_PatientDaysSinceLastDischarge]
			)
        )
		   AND [begin_dt] IS NOT NULL 
		   AND DATEDIFF(day, [begin_dt], GETDATE()) > 30 -- delete records that were never admitted to a device which are older than 30 days

    SET @RC += @@ROWCOUNT;
    
	IF (@RC <> 0 )
    SET @EncounterDataPurged = @RC;
END
