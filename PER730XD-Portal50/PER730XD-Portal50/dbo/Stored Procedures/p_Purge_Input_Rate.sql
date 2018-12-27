
CREATE PROCEDURE [dbo].[p_Purge_Input_Rate]
AS
  BEGIN
    DECLARE
      @MR AS INT,
      @WF AS INT,
      @TL AS INT,
      @AL AS INT,
      @ML AS INT,
      @PJ AS INT,
      @CE AS INT,
      @HS AS INT,
      @HE AS INT,
      @HN AS INT,
      @HP AS INT
    DECLARE @tmp_io_avg TABLE (
      [timeperiod] VARCHAR( 12 ),
      [tcount]     INT)

    /* Monitor results */
    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, obs_start_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, obs_start_dt, 8 ),
                                                                    1,
                                                                    2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_result
      -- where
      GROUP  BY ( CONVERT( VARCHAR, obs_start_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, obs_start_dt, 8 ),
                                                                         1,
                                                                         2 ) )

    SET @MR = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* Waveform */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, start_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, start_dt, 8 ),
                                                                1,
                                                                2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_waveform
      -- where
      GROUP  BY ( CONVERT( VARCHAR, start_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, start_dt, 8 ),
                                                                     1,
                                                                     2 ) )

    SET @WF = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* 12 Lead */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, param_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, param_dt, 8 ),
                                                                1,
                                                                2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_param_timetag
      -- where
      GROUP  BY ( CONVERT( VARCHAR, param_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, param_dt, 8 ),
                                                                     1,
                                                                     2 ) )

    SET @TL = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* Alarm */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, start_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, start_dt, 8 ),
                                                                1,
                                                                2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_alarm
      -- where
      GROUP  BY ( CONVERT( VARCHAR, start_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, start_dt, 8 ),
                                                                     1,
                                                                     2 ) )

    SET @AL = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* Message Log */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, msg_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, msg_dt, 8 ),
                                                              1,
                                                              2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_msg_log
      WHERE  external_id IS NULL
      GROUP  BY ( CONVERT( VARCHAR, msg_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, msg_dt, 8 ),
                                                                   1,
                                                                   2 ) )

    SET @ML = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* Print Job */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, job_net_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, job_net_dt, 8 ),
                                                                  1,
                                                                  2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_print_job
      -- where
      GROUP  BY ( CONVERT( VARCHAR, job_net_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, job_net_dt, 8 ),
                                                                       1,
                                                                       2 ) )

    SET @PJ = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* CEI */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, event_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, event_dt, 8 ),
                                                                1,
                                                                2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   int_event_log
      -- where
      GROUP  BY ( CONVERT( VARCHAR, event_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, event_dt, 8 ),
                                                                     1,
                                                                     2 ) )

    SET @CE = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* HL7 Success */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                               1,
                                                               2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   hl7_out_queue
      WHERE  msg_status = 'R'
      GROUP  BY ( CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                                    1,
                                                                    2 ) )

    SET @HS = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* HL7 Error */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                               1,
                                                               2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   hl7_out_queue
      WHERE  msg_status = 'E'
      GROUP  BY ( CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                                    1,
                                                                    2 ) )

    SET @HE = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* HL7 Not read */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                               1,
                                                               2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   hl7_out_queue
      WHERE  msg_status = 'N'
      GROUP  BY ( CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                                    1,
                                                                    2 ) )

    SET @HN = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    /* HL7 Pending */
    DELETE @tmp_io_avg

    INSERT INTO @tmp_io_avg
      SELECT CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                               1,
                                                               2 ) AS TIMEPERIOD,
             COUNT(*) AS TCOUNT
      FROM   hl7_out_queue
      WHERE  msg_status = 'P'
      GROUP  BY ( CONVERT( VARCHAR, sent_dt, 2 ) + ' ' + SubString( CONVERT( VARCHAR, sent_dt, 8 ),
                                                                    1,
                                                                    2 ) )

    SET @HP = ( SELECT avg( tcount )
                FROM   @tmp_io_avg )

    SELECT @MR AS MONITORRESULTRATE,
           @WF AS WAVEFORMRATE,
           @TL AS TWELVELEADRATE,
           @AL AS ALARMRATE,
           @ML AS MESSAGELOGRATE,
           @PJ AS PRINTJOBRATE,
           @CE AS CLINICALEVENTRATE,
           @HS AS HL7SUCCESSRATE,
           @HE AS HL7ERRORRATE,
           @HN AS HL7NOTREADRATE,
           @HP AS HL7PENDINGRATE
  END

