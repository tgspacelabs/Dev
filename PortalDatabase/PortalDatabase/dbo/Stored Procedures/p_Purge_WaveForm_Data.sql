CREATE PROCEDURE [dbo].[p_Purge_WaveForm_Data]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @WaveformDataPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ipc]
        FROM
            [dbo].[int_patient_channel] AS [ipc]
            INNER JOIN [dbo].[int_patient_monitor] AS [ipm] ON [ipc].[patient_monitor_id] = [ipm].[patient_monitor_id]
            INNER JOIN [dbo].[int_encounter] AS [ie] ON [ipm].[encounter_id] = [ie].[encounter_id]
        WHERE
            [ie].[discharge_dt] < @PurgeDate
            AND [ipc].[active_sw] IS NULL;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [at]
        FROM
            [dbo].[AnalysisTime] AS [at]
        WHERE
            [at].[insert_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [wf]
        FROM
            [dbo].[int_waveform] AS [wf]
        WHERE
            [wf].[end_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @WaveformDataPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge old Waveform data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_WaveForm_Data';

