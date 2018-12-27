CREATE PROCEDURE [dbo].[p_Purge_Encounter_Data]
    (
     @FChunkSize INT,
     @EncounterDataPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;

    SET @EncounterDataPurged = 0; -- Initialize to remove code analysis warning.

    -- Delete Encounter first as the root, then delete other leaves
    DELETE
        [iem]
    FROM
        [dbo].[int_encounter_map] AS [iem]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [id]
    FROM
        [dbo].[int_diagnosis] AS [id]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [idd]
    FROM
        [dbo].[int_diagnosis_drg] AS [idd]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ig]
    FROM
        [dbo].[int_guarantor] AS [ig]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [io]
    FROM
        [dbo].[int_order] AS [io]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [iom]
    FROM
        [dbo].[int_order_map] AS [iom]
    WHERE
        [order_id] NOT IN (SELECT
                            [order_id]
                           FROM
                            [dbo].[int_order]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [iol]
    FROM
        [dbo].[int_order_line] AS [iol]
    WHERE
        [order_id] NOT IN (SELECT
                            [order_id]
                           FROM
                            [dbo].[int_order]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ipld]
    FROM
        [dbo].[int_patient_list_detail] AS [ipld]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [iethi]
    FROM
        [dbo].[int_encounter_to_hcp_int] AS [iethi]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ieth]
    FROM
        [dbo].[int_encounter_tfr_history] AS [ieth]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ipm]
    FROM
        [dbo].[int_patient_monitor] AS [ipm]
    WHERE
        [encounter_id] NOT IN (SELECT
                                [encounter_id]
                               FROM
                                [dbo].[int_encounter])
        AND ISNULL([active_sw], 0) <> 1;

    SET @RC += @@ROWCOUNT;

    DELETE
        [ia]
    FROM
        [dbo].[int_account] AS [ia]
    WHERE
        [account_id] NOT IN (SELECT
                                [account_id]
                             FROM
                                [dbo].[int_encounter]);

    SET @RC += @@ROWCOUNT;

    DELETE TOP (@FChunkSize)
        [ipc]
    FROM
        [dbo].[int_patient_channel] AS [ipc]
    WHERE
        [patient_id] IN (SELECT
                            [PatientId]
                         FROM
                            [dbo].[v_PatientDaysSinceLastDischarge]
                         WHERE
                            [DaysSinceLastDischarge] >= 10);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ip]
    FROM
        [dbo].[int_person] AS [ip]
    WHERE
        [person_id] IN (SELECT
                            [PatientId]
                        FROM
                            [dbo].[v_PatientDaysSinceLastDischarge]
                        WHERE
                            [DaysSinceLastDischarge] >= 10);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ip]
    FROM
        [dbo].[int_patient] AS [ip]
    WHERE
        [patient_id] IN (SELECT
                            [PatientId]
                         FROM
                            [dbo].[v_PatientDaysSinceLastDischarge]
                         WHERE
                            [DaysSinceLastDischarge] >= 10);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ipn]
    FROM
        [dbo].[int_person_name] AS [ipn]
    WHERE
        [person_nm_id] IN (SELECT
                            [PatientId]
                           FROM
                            [dbo].[v_PatientDaysSinceLastDischarge]
                           WHERE
                            [DaysSinceLastDischarge] >= 10);

    SET @RC += @@ROWCOUNT;

    DELETE
        [imm]
    FROM
        [dbo].[int_mrn_map] AS [imm]
    WHERE
        [patient_id] IN (SELECT
                            [PatientId]
                         FROM
                            [dbo].[v_PatientDaysSinceLastDischarge]
                         WHERE
                            [DaysSinceLastDischarge] >= 10);

    SET @RC += @@ROWCOUNT;

    DELETE
        [ie]
    FROM
        [dbo].[int_encounter] AS [ie]
    WHERE
        [encounter_id] IN (SELECT
                            [encounter_id]
                           FROM
                            [dbo].[int_encounter]
                           WHERE
                            [patient_id] IN (SELECT
                                                [PatientId]
                                             FROM
                                                [dbo].[v_PatientDaysSinceLastDischarge]
                                             WHERE
                                                [DaysSinceLastDischarge] >= 10));

    SET @RC += @@ROWCOUNT;
    
    -- Delete those rows which have a [monitor_created] value that is NULL and use the [mod_dt] instead
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ie]
        FROM
            [dbo].[int_encounter] AS [ie]
        WHERE
            [ie].[monitor_created] IS NULL -- Generally created by Admit, Discharge, Transfer (ADT)
            AND DATEDIFF(DAY, [ie].[mod_dt], GETDATE()) > 30; -- delete records that were never admitted to a device which are older than 30 days

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;
    
    IF (@RC <> 0)
    BEGIN
        SET @EncounterDataPurged = @RC;
    END
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge encounter data which is no longer needed or allowed by licensing.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_Encounter_Data';

