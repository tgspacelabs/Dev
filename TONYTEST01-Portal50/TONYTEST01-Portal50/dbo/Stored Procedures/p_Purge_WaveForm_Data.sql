﻿
/* Waveform data */
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
        DELETE TOP (@FChunkSize) ipc 
        FROM [dbo].[int_patient_channel] ipc
            INNER JOIN [dbo].[int_patient_monitor] ipm 
                ON ipc.[patient_monitor_id] = ipm.[patient_monitor_id]
            INNER JOIN [dbo].[int_encounter] ie 
                ON IPM.[encounter_id] = ie.[encounter_id] 
        WHERE ie.[discharge_dt] < @PurgeDate 
            AND ipc.[active_sw] IS NULL;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) at 
        FROM [dbo].[AnalysisTime] at 
        WHERE at.[insert_dt] < @PurgeDate

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) wf 
        FROM [dbo].[int_waveform] wf 
        WHERE wf.[end_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @WaveformDataPurged = @RC;
END
