

/* Stored procedure to purge all the purging tasks*/
CREATE PROCEDURE [dbo].[usp_PurgeTasks]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @ChunkSize INT = 200;

        /* Order of purging the data
        --HL7Success
        --HL7Error
        --MonitorResults
        --EventsData
        --TwelveLead
        --Alarm
        --PrintJob
        --MsgLog
        --ChunkSize
        --HL7NotRead
        --CEILog
        --DebugWaveforms
        --HL7Pending
        --Encounter
        --CHAUDITLOG
        --CHPATSETTINGS
        --CHLOGDATA
        */

        DECLARE @Hl7SuccessPurgeDate DATETIME, @HL7SuccessRowsPurged INT;
        EXEC PurgerParameters 'HL7Success', @PurgeDate = @HL7SuccessPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @HL7ErrorPurgeDate DATETIME, @HL7ErrorRowsPurged INT;
        EXEC PurgerParameters 'HL7Error', @PurgeDate = @HL7ErrorPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;
 
        DECLARE @MonitorResultsPurgeDate DATETIME, @HL7MonitorRowsPurged INT;
        EXEC PurgerParameters 'MonitorResults', @PurgeDate = @MonitorResultsPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;
        --DECLARE @MonitorResultsPurgeDateUTC DATETIME = DATEADD(hour, 1, dbo.fnLocalDateTimeToUtcTime(@MonitorResultsPurgeDate)); -- add 1 hour as fnLocalDateTimeToUtcTime does not handle daylight savings shift well
        
        DECLARE @EventsDataPurgeDate DATETIME, @EventsDataRowsPurged INT;
        EXEC PurgerwaveformParameters @PurgeDate = @EventsDataPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;
        DECLARE @EventsDataPurgeDateUTC DATETIME = DATEADD(hour, 1, dbo.fnLocalDateTimeToUtcTime(@EventsDataPurgeDate)); -- add 1 hour as fnLocalDateTimeToUtcTime does not handle daylight savings shift well

        DECLARE @TwelveLeadRowsPurgeDate DATETIME, @TwelveLeadRowsPurged INT;
        EXEC PurgerParameters 'TwelveLead', @PurgeDate = @TwelveLeadRowsPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @AlarmRowsPurgedDate DATETIME, @AlarmsRowsPurged INT;
        EXEC PurgerParameters 'Alarm', @PurgeDate = @AlarmRowsPurgedDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;
        DECLARE @AlarmRowsPurgedDateUTC DATETIME = DATEADD(hour, 1, dbo.fnLocalDateTimeToUtcTime(@AlarmRowsPurgedDate)); -- add 1 hour as fnLocalDateTimeToUtcTime does not handle daylight savings shift well
        
        DECLARE @PrintJobsPurgedDate DATETIME, @PrintJobsPurgeCount INT;
        EXEC PurgerParameters 'PrintJob', @PurgeDate = @PrintJobsPurgedDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;
        
        DECLARE @MessageLogPurgeDate DATETIME, @MessageLogPurgeCount INT;
        EXEC PurgerParameters 'MsgLog', @PurgeDate = @MessageLogPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @HL7NotReadPurgedDate DATETIME, @HL7NotReadPurged INT;
        EXEC PurgerParameters 'HL7NotRead', @PurgeDate = @HL7NotReadPurgedDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @CEILogPurgeDate DATETIME, @CEILogPurged INT;
        EXEC PurgerParameters 'CEILog', @PurgeDate = @CEILogPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @WaveformPurgeDate DATETIME, @WaveformDataPurged INT;
        EXEC PurgerwaveformParameters @PurgeDate = @WaveformPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;
        DECLARE @WaveformPurgeDateUTC DATETIME = DATEADD(hour, 1, dbo.fnLocalDateTimeToUtcTime(@WaveformPurgeDate)); -- add 1 hour as fnLocalDateTimeToUtcTime does not handle daylight savings shift well
        
        DECLARE @HL7PendingPurgeDate DATETIME, @HL7PendingDataPurged INT;
        EXEC PurgerParameters 'HL7Pending', @PurgeDate = @HL7PendingPurgeDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @EncounterDataPurged INT;
        
        DECLARE @CHAuditLogDate DATETIME, @ChAuditDataPurged INT;
        EXEC PurgerParameters 'CHAUDITLOG', @PurgeDate = @CHAuditLogDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @CHPatientSettingsDate DATETIME, @PatientSettingsDataPurged int;
        EXEC PurgerParameters 'CHPATSETTINGS', @PurgeDate = @CHPatientSettingsDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        DECLARE @CHLogDataDate DATETIME, @CHLogDataPurged int;
        EXEC PurgerParameters 'CHLOGDATA', @PurgeDate = @CHLogDataDate OUTPUT, @ChunkSize = @ChunkSize OUTPUT;

        SET @HL7SuccessRowsPurged = 0; --Initial value
        SET @HL7ErrorRowsPurged = 0; --Initial value
        SET @HL7MonitorRowsPurged = 0; --Initial value
        SET @EventsDataRowsPurged = 0; --Initial value
        SET @TwelveLeadRowsPurged = 0; --Initial value
        SET @AlarmsRowsPurged = 0; --Initial value
        SET @PrintJobsPurgeCount = 0; --Initial value
        SET @MessageLogPurgeCount = 0; --Initial value
        SET @HL7NotReadPurged = 0; --Initial value
        SET @CEILogPurged = 0; --Initial value
        SET @WaveformDataPurged = 0; --Initial value
        SET @HL7PendingDataPurged = 0; --Initial value
        SET @ChAuditDataPurged = 0; --Initial value
        SET @EncounterDataPurged = 0; --Initial value
        SET @PatientSettingsDataPurged = 0; --Initial value
        SET @CHLogDataPurged = 0; --Initial value
        
        /* To purge the Hl7 Success data which is older than the configured interval*/
        EXEC dbo.p_Purge_HL7_Success @FChunkSize = @ChunkSize, @PurgeDate = @Hl7SuccessPurgeDate, @HL7SuccessRowsPurged = @HL7SuccessRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@HL7SuccessRowsPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_HL7_Success) at configured time interval : ' + RTRIM(CAST(@Hl7SuccessPurgeDate AS NVARCHAR(30))) +  N'.');
        
        /* To purge the Hl7 Error data which is older than the configured interval*/
        EXEC dbo.p_Purge_hl7_Error @FChunkSize = @ChunkSize, @PurgeDate = @Hl7ErrorPurgeDate, @HL7ErrorRowsPurged = @HL7ErrorRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@HL7ErrorRowsPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_hl7_Error) at configured time interval : ' + RTRIM(CAST(@Hl7ErrorPurgeDate AS NVARCHAR(30))) +  N'.');
    
        /* To purge the Monitor data which is older than the configured interval*/
        SET @HL7MonitorRowsPurged = 0; --Resetting
        EXEC dbo.p_Purge_Result_Data @FChunkSize = @ChunkSize, @PurgeDate = @MonitorResultsPurgeDate, @HL7MonitorRowsPurged = @HL7MonitorRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@HL7MonitorRowsPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_Result_Data) at configured time interval : ' + RTRIM(CAST(@MonitorResultsPurgeDate AS NVARCHAR(30))) +  N'.');

        /* To purge the Monitor data which is older than the configured interval*/
        EXEC [dbo].[usp_PurgeEventsData] @FChunkSize = @ChunkSize, @PurgeDate = @EventsDataPurgeDateUTC, @EventsDataRowsPurged = @EventsDataRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@EventsDataRowsPurged AS NVARCHAR(20)) + ') purged from ICS (usp_PurgeEventsData) at configured time interval : ' + RTRIM(CAST(@EventsDataPurgeDateUTC AS NVARCHAR(30))) +  N'.');

        SET @HL7MonitorRowsPurged = 0; --Resetting
        EXEC [dbo].[usp_PurgeDlVitalsData] @FChunkSize = @ChunkSize, @PurgeDateUTC = @MonitorResultsPurgeDate, @HL7MonitorRowsPurged = @HL7MonitorRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@HL7MonitorRowsPurged AS NVARCHAR(20)) + ') purged from ICS (usp_PurgeDlVitalsData) at configured time interval : ' + RTRIM(CAST(@MonitorResultsPurgeDate AS NVARCHAR(30))) +  N'.');

        /* To purge the TweleveLead data which is older than the configured interval*/
        EXEC dbo.p_Purge_12Lead_Data @FChunkSize = @ChunkSize, @PurgeDate = @TwelveLeadRowsPurgeDate, @TwelveLeadRowsPurged = @TwelveLeadRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@TwelveLeadRowsPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_12Lead_Data) at configured time interval : ' + RTRIM(CAST(@TwelveLeadRowsPurgeDate AS NVARCHAR(30))) +  N'.');
        
        /* To purge the Alarm data which is older than the configured interval*/
        EXEC dbo.p_Purge_Alarm_Data @FChunkSize = @ChunkSize, @PurgeDate = @AlarmRowsPurgedDate, @AlarmsRowsPurged = @AlarmsRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@AlarmsRowsPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_Alarm_Data) at configured time interval : ' + RTRIM(CAST(@AlarmRowsPurgedDate AS NVARCHAR(30))) +  N'.');

        SET @AlarmsRowsPurged = 0; --Resetting
        EXEC dbo.usp_PurgeDlAlarmData @FChunkSize = @ChunkSize, @PurgeDateUTC = @AlarmRowsPurgedDateUTC, @AlarmsRowsPurged = @AlarmsRowsPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@AlarmsRowsPurged AS NVARCHAR(20)) + ') purged from ICS (usp_PurgeDlAlarmData) at configured time interval : ' + RTRIM(CAST(@AlarmRowsPurgedDate AS NVARCHAR(30))) +  N'.');
        
        /* To purge the Prints jobs data which is older than the configured interval*/
        EXEC dbo.p_Purge_Print_Job_Data @FChunkSize = @ChunkSize, @PurgeDate = @PrintJobsPurgedDate, @PrintJobsPurged = @PrintJobsPurgeCount OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@PrintJobsPurgeCount AS NVARCHAR(20)) + ') purged from ICS (p_Purge_Print_Job_Data) at configured time interval : ' + RTRIM(CAST(@PrintJobsPurgedDate AS NVARCHAR(30))) +  N'.');

        /*
        SET @PrintJobsPurgeCount = 0; --Resetting the value
        -- NO DL PRINT JOBS USED IN THE CURRENT ICS VERSION
        EXEC dbo.usp_PurgeDlPrintJobsData @FChunkSize = @ChunkSize, @PurgeDate = @PrintJobsPurgedDate, @PrintJobsPurgeCount = @PrintJobsPurgeCount OUTPUT
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@PrintJobsPurgeCount AS NVARCHAR(20)) + ') purged from ICS (usp_PurgeDlPrintJobsData) at configured time interval : ' + RTRIM(CAST(@PrintJobsPurgedDate AS NVARCHAR(30))) +  N'.');
        */

        SET @PrintJobsPurgeCount = 0; -- Resetting
        EXEC dbo.p_Purge_ETPrintJobs_Data @FChunkSize = @ChunkSize, @PurgeDate = @PrintJobsPurgedDate, @PrintJobsPurged = @PrintJobsPurgeCount OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@PrintJobsPurgeCount AS NVARCHAR(20)) + ') purged from ICS (p_Purge_ETPrintJobs_Data) at configured time interval : ' + RTRIM(CAST(@PrintJobsPurgedDate AS NVARCHAR(30))) +  N'.');

        /* To purge the Message log data which is older than the configured interval*/
        EXEC dbo.p_Purge_msg_Log_Data @FChunkSize = @ChunkSize, @PurgeDate = @MessageLogPurgeDate, @MessageLogPurged = @MessageLogPurgeCount OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@MessageLogPurgeCount AS NVARCHAR(20)) + ') purged from ICS (p_Purge_msg_Log_Data) at configured time interval : ' + RTRIM(CAST(@MessageLogPurgeDate AS NVARCHAR(30))) +  N'.');    
        
        /* To purge the Hl7 Not Read data which is older than the configured interval*/
        EXEC dbo.p_Purge_hl7_Not_Read @FChunkSize = @ChunkSize, @PurgeDate = @HL7NotReadPurgedDate, @HL7NotReadPurged = @HL7NotReadPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@HL7NotReadPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_hl7_Not_Read) at configured time interval : ' + RTRIM(CAST(@HL7NotReadPurgedDate AS NVARCHAR(30))) +  N'.');    
        
        /* To purge the CEI data which is older than the configured interval*/
        EXEC dbo.p_Purge_CEI_Log_Data @FChunkSize = @ChunkSize, @PurgeDate = @CEILogPurgeDate, @CEILogPurged = @CEILogPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@CEILogPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_CEI_Log_Data) at configured time interval : ' + RTRIM(CAST(@CEILogPurgeDate AS NVARCHAR(30))) +  N'.');
        
        /* To purge the Waveform data which is older than the configured interval*/
        EXEC dbo.p_Purge_WaveForm_Data @FChunkSize = @ChunkSize, @PurgeDate = @WaveformPurgeDate, @WaveformDataPurged = @WaveformDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@WaveformDataPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_WaveForm_Data) at configured time interval : ' + RTRIM(CAST(@WaveformPurgeDate AS NVARCHAR(30))) +  N'.');

        SET @WaveformDataPurged = 0; --Resetting
        EXEC dbo.usp_PurgeDlWaveformData  @FChunkSize = @ChunkSize, @PurgeDateUTC = @WaveformPurgeDateUTC, @WaveformDataPurged = @WaveformDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@WaveformDataPurged AS NVARCHAR(20)) + ') purged from ICS (usp_PurgeDlWaveformData) at configured time interval : ' + RTRIM(CAST(@WaveformPurgeDate AS NVARCHAR(30))) +  N'.');
                
        /* To purge the Hl7 Pending data which is older than the configured interval*/
        EXEC dbo.p_Purge_HL7_Pending @FChunkSize = @ChunkSize, @PurgeDate = @HL7PendingPurgeDate, @HL7PendingDataPurged = @HL7PendingDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@HL7PendingDataPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_HL7_Pending) at configured time interval : ' + RTRIM(CAST(@HL7PendingPurgeDate AS NVARCHAR(30))) +  N'.');
    
        /* To purge the Encounter data(here the purge is doing for the date before 10 days*/
        EXEC dbo.p_Purge_Encounter_Data @FChunkSize = @ChunkSize, @EncounterDataPurged = @EncounterDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@EncounterDataPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_Encounter_Data).');

        SET @EncounterDataPurged = 0; --Resetting
        EXEC dbo.usp_PurgeDlEncounterData @FChunkSize = @ChunkSize, @EncounterDataPurged = @EncounterDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@EncounterDataPurged AS NVARCHAR(20)) + ') purged from ICS (usp_PurgeDlEncounterData).');
         
        /* To purge the CH Audit log data which is older than the configured interval*/
        EXEC dbo.p_Purge_ch_Audit_Log @FChunkSize = @ChunkSize, @PurgeDate = @CHAuditLogDate, @ChAuditDataPurged = @ChAuditDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@ChAuditDataPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_ch_Audit_Log) at configured time interval : ' + RTRIM(CAST(@CHAuditLogDate AS NVARCHAR(30))) +  N'.');

        /* To purge the CH Patient Settings data which is older than the configured interval*/
        EXEC dbo.p_Purge_ch_Patient_Settings @FChunkSize = @ChunkSize, @PurgeDate = @CHPatientSettingsDate, @PatientSettingsDataPurged = @PatientSettingsDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@PatientSettingsDataPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_ch_Patient_Settings) at configured time interval : ' + RTRIM(CAST(@CHPatientSettingsDate AS NVARCHAR(30))) +  N'.');

        /* To purge the CH Log data which is older than the configured interval*/
        EXEC dbo.p_Purge_ch_Log_Data @FChunkSize = @ChunkSize, @PurgeDate = @CHLogDataDate, @CHLogDataPurged = @CHLogDataPurged OUTPUT;
        PRINT(CONVERT(VARCHAR(30), GETDATE(), 121) + ' -- Records (' + CAST(@CHLogDataPurged AS NVARCHAR(20)) + ') purged from ICS (p_Purge_ch_Log_Data) at configured time interval : ' + RTRIM(CAST(@CHLogDataDate AS NVARCHAR(30))) +  N'.');
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();

        -- Use RAISERROR inside the CATCH block to return error
        -- information about the original error that caused
        -- execution to jump to the CATCH block.
        RAISERROR (@ErrorMessage, -- Message text.
                    @ErrorSeverity, -- Severity.
                    @ErrorState -- State.
                    );
    END CATCH
END --Closing the SP
