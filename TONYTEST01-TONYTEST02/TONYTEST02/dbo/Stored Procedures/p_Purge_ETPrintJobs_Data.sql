
--====================================================================================================================
--=================================================p_Purge_ETPrintJobs_Data==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Purges old alarm report data previously saved for ET Print Jobs. Used by the ICS_PurgeData SqlAgentJob.
-- =======================================================================
CREATE PROCEDURE [dbo].[p_Purge_ETPrintJobs_Data]
(
    @FChunkSize INT, 
    @PurgeDate DATETIME, 
    @PrintJobsPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        -- Delete alarm data
        DELETE TOP (@FChunkSize) 
        FROM [dbo].[int_print_job_et_alarm] 
        WHERE RowLastUpdatedOn <= @PurgeDate
              AND AlarmEndTimeUTC IS NOT NULL

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    -- Delete vitals data
    SELECT DISTINCT 
        [Vitals].[Id]
    INTO #vitalsToDelete
    FROM [dbo].[int_print_job_et_vitals] Vitals 
        LEFT OUTER JOIN [dbo].[int_print_job_et_alarm] Alarm 
        ON [Vitals].TopicSessionId = Alarm.TopicSessionId
            AND [Vitals].ResultTimeUTC >= Alarm.AlarmStartTimeUTC
            AND [Vitals].ResultTimeUTC <= Alarm.AlarmEndTimeUTC
    WHERE Alarm.TopicSessionId IS NULL -- We only want the Ids where there is no corresponding Alarm

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) 
        FROM [dbo].[int_print_job_et_vitals]
        WHERE int_print_job_et_vitals.Id IN (SELECT Id FROM #vitalsToDelete)

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    -- Delete waveform data
    SELECT 
        [Waveform].[Id]
    INTO #waveformsToDelete
    FROM [dbo].[int_print_job_et_waveform] Waveform 
        LEFT OUTER JOIN [dbo].[int_print_job_et_alarm] Alarm 
        ON [Waveform].DeviceSessionId = [Alarm].DeviceSessionId
           AND [Waveform].StartTimeUTC < [Alarm].AlarmEndTimeUTC 
        AND [Waveform].EndTimeUTC > [Alarm].AlarmStartTimeUTC
    WHERE Alarm.TopicSessionId IS NULL -- We only want the Ids where there is no corresponding Alarm

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) 
        FROM [dbo].[int_print_job_et_waveform]
        WHERE Id IN (SELECT Id FROM #waveformsToDelete)

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @PrintJobsPurged = @RC
END

