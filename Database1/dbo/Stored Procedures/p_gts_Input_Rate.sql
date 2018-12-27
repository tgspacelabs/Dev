
CREATE PROCEDURE [dbo].[p_gts_Input_Rate]
    (
    @MinutesTimeSlice AS INT = 15,
    @Save AS CHAR(1) = 'N',
    @referenceTime AS DATETIME = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @cutoffdt AS DATETIME,
        @ucutoffdt AS DATETIME,
        @basetime AS DATETIME,
        @baseminute AS INT;

    DECLARE @inprate TABLE
        (
         [input_type] VARCHAR(20),
         [period_start] DATETIME NOT NULL,
         [period_len] INT NOT NULL,
         [rate_counter] INT NOT NULL
        );

    SET DEADLOCK_PRIORITY LOW;

    IF (@MinutesTimeSlice IS NULL)
        SET @MinutesTimeSlice = 15;

    IF (@Save IS NULL)
        SET @Save = 'N';

    IF (@referenceTime IS NULL)
        SET @referenceTime = GETDATE();

    SET @basetime = DATEADD(HOUR, DATEDIFF(HOUR, 0, @referenceTime), 0);
    SET @baseminute = FLOOR(DATEPART(MI, @referenceTime) / @MinutesTimeSlice) * @MinutesTimeSlice;

    SET @ucutoffdt = DATEADD(MINUTE, @baseminute, @basetime);
    SET @cutoffdt = DATEADD(MINUTE, -(@MinutesTimeSlice), @ucutoffdt);

    -- Monitor results
    INSERT  INTO @inprate
    SELECT
        'MonitorResults',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_result]
    WHERE
        [obs_start_dt] >= @cutoffdt
        AND [obs_start_dt] < @ucutoffdt;

    -- Waveform
    INSERT  INTO @inprate
    SELECT
        'WaveFormData',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_waveform]
    WHERE
        [start_dt] >= @cutoffdt
        AND [start_dt] < @ucutoffdt;

    -- 12 Lead
    INSERT  INTO @inprate
    SELECT
        'TwelveLead',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_param_timetag]
    WHERE
        [param_dt] >= @cutoffdt
        AND [param_dt] < @ucutoffdt;

    -- Alarm
    INSERT  INTO @inprate
    SELECT
        'Alarm',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_alarm]
    WHERE
        [start_dt] >= @cutoffdt
        AND [start_dt] < @ucutoffdt;

    -- Message Log
    INSERT  INTO @inprate
    SELECT
        'MsgLog',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_msg_log]
    WHERE
        [msg_dt] >= @cutoffdt
        AND [msg_dt] < @ucutoffdt;

    -- Print_Job
    INSERT  INTO @inprate
    SELECT
        'PrintJob',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_print_job]
    WHERE
        [job_net_dt] >= @cutoffdt
        AND [job_net_dt] < @ucutoffdt;

    -- Clinical Event Interface
    INSERT  INTO @inprate
    SELECT
        'CEILog',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[int_event_log]
    WHERE
        [event_dt] >= @cutoffdt
        AND [event_dt] < @ucutoffdt;

    -- HL7 Success
    INSERT  INTO @inprate
    SELECT
        'HL7Success',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[hl7_out_queue] AS [hoq]
    WHERE
        [hoq].[sent_dt] >= @cutoffdt
        AND [hoq].[sent_dt] < @ucutoffdt
        AND [hoq].[msg_status] = N'R';

    -- HL7 Error
    INSERT  INTO @inprate
    SELECT
        'HL7Error',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[hl7_out_queue] AS [hoq]
    WHERE
        [hoq].[sent_dt] >= @cutoffdt
        AND [hoq].[sent_dt] < @ucutoffdt
        AND [hoq].[msg_status] = N'E';

    -- HL7 Not Read
    INSERT  INTO @inprate
    SELECT
        'HL7NotRead',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[hl7_out_queue] AS [hoq]
    WHERE
        [hoq].[sent_dt] >= @cutoffdt
        AND [hoq].[sent_dt] < @ucutoffdt
        AND [hoq].[msg_status] = N'N';

    -- HL7 Pending
    INSERT  INTO @inprate
    SELECT
        'HL7Pending',
        @cutoffdt,
        @MinutesTimeSlice,
        COUNT(*)
    FROM
        [dbo].[hl7_out_queue] AS [hoq]
    WHERE
        [hoq].[sent_dt] >= @cutoffdt
        AND [hoq].[sent_dt] < @ucutoffdt
        AND [hoq].[msg_status] = N'P';

    -- Saves Counter
    IF (@Save = 'Y')
    BEGIN
        IF NOT EXISTS ( SELECT TOP (1)
                            [period_len]
                        FROM
                            [dbo].[gts_input_rate]
                        WHERE
                            [period_start] = @cutoffdt
                            AND [period_len] = @MinutesTimeSlice )
            INSERT  INTO [dbo].[gts_input_rate]
                    ([input_type],
                     [period_start],
                     [period_len],
                     [rate_counter]
                    )
            SELECT
                [input_type],
                [period_start],
                [period_len],
                [rate_counter]
            FROM
                @inprate;
    END;

    SELECT
        [input_type],
        [period_start],
        [period_len],
        [rate_counter]
    FROM
        @inprate;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_gts_Input_Rate';

