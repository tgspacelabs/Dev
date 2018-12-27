
CREATE PROCEDURE [dbo].[p_Purge_12Lead_Data]
(
    @FChunkSize INT,
    @PurgeDate DATETIME,
    @TwelveLeadRowsPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) isew 
        FROM  [dbo].[int_saved_event_waveform] isew
            INNER JOIN [dbo].[int_saved_event] ise 
                ON isew.[event_id] = ise.[event_id]
                AND isew.[patient_id] = ise.[patient_id]
        WHERE ise.[insert_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    -- Nancy on 2/28/08, Fix for CR Isq#2661
    -- Don't handle parent table data here since other child table data need them 
    --    SET ROWCOUNT 0
    --    DELETE [dbo].[int_patient_monitor]
    --    FROM [dbo].[int_encounter] ie
    --    WHERE int_patient_monitor.encounter_id = ie.encounter_id
    --    AND discharge_dt < @PurgeDate
    --    AND isnull(active_sw, 0) = 0;
    --    SET @RC += @@ROWCOUNT;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) ilre
        FROM [dbo].[int_12lead_report_edit] ilre
            INNER JOIN [dbo].[int_12lead_report] i12r
                ON ilre.[report_id] = i12r.[report_id]
        WHERE i12r.[report_dt] < @PurgeDate;
            
        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) ipt 
        FROM [dbo].[int_param_timetag] ipt
        WHERE ipt.[param_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) ise 
        FROM [dbo].[int_SavedEvent] ise
        WHERE ise.[insert_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) ilr
        FROM [dbo].[int_12lead_report] ilr
        WHERE ilr.[report_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @TwelveLeadRowsPurged = @RC;
END
