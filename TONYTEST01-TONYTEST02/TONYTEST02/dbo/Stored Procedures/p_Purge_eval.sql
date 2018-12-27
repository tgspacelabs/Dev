
CREATE PROCEDURE [dbo].[p_Purge_eval]
  (
  @ReferenceDate AS DATETIME
  )
AS
  BEGIN
    DECLARE
      @MR  AS INT,
      @WF  AS INT,
      @TL  AS INT,
      @AL  AS INT,
      @ML  AS INT,
      @PJ  AS INT,
      @CE  AS INT,
      @HS  AS INT,
      @HE  AS INT,
      @HN  AS INT,
      @HP  AS INT,
      /* Totals */
      @TMR AS INT,
      @TWF AS INT,
      @TTL AS INT,
      @TAL AS INT,
      @TML AS INT,
      @TPJ AS INT,
      @TCE AS INT,
      @THS AS INT,
      @THE AS INT,
      @THN AS INT,
      @THP AS INT

    /* Reference date or current date */
    IF @ReferenceDate IS NULL
      SET @ReferenceDate = GetDate( )

    /* Int Result */
    SET @MR =( SELECT COUNT(*)
               FROM   int_result
               WHERE  obs_start_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( parm_value AS INT ) * -1
                                          FROM   int_system_parameter
                                          WHERE  active_flag = 1 AND name = 'MonitorResults' ),
                                        @ReferenceDate ) ) )
    SET @TMR =( SELECT COUNT(*)
                FROM   int_result ) - @MR
    /* int_waveform */
    SET @WF =( SELECT COUNT(*)
               FROM   int_waveform
               WHERE  start_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( setting AS INT ) * -1
                                          FROM   int_sysgen
                                          WHERE  product_cd = 'fulldiscl' AND feature_cd = 'NUMBER_OF_HOURS' ),
                                        @ReferenceDate ) ) )
    SET @TWF =( SELECT COUNT(*)
                FROM   int_waveform ) - @WF
    /* 12Lead */
    SET @TL =( SELECT COUNT(*)
               FROM   int_param_timetag
               WHERE  param_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( parm_value AS INT ) * -1
                                          FROM   int_system_parameter
                                          WHERE  active_flag = 1 AND name = 'TwelveLead' ),
                                        @ReferenceDate ) ) )
    SET @TTL =( SELECT COUNT(*)
                FROM   int_param_timetag ) - @TL
    /* alarm */
    SET @AL =( SELECT COUNT(*)
               FROM   int_alarm
               WHERE  start_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( parm_value AS INT ) * -1
                                          FROM   int_system_parameter
                                          WHERE  active_flag = 1 AND name = 'Alarm' ),
                                        @ReferenceDate ) ) )
    SET @TAL =( SELECT COUNT(*)
                FROM   int_alarm ) - @AL
    /* Message log */
    SET @ML =( SELECT COUNT(*)
               FROM   int_msg_log
               WHERE  msg_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( parm_value AS INT ) * -1
                                          FROM   int_system_parameter
                                          WHERE  active_flag = 1 AND name = 'Alarm' ),
                                        @ReferenceDate ) ) AND external_id IS NULL )
    SET @TML =( SELECT COUNT(*)
                FROM   int_msg_log
                WHERE  external_id IS NULL ) - @ML
    /* Print Job Data */
    SET @PJ =( SELECT COUNT(*)
               FROM   int_print_job
               WHERE  job_net_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( parm_value AS INT ) * -1
                                          FROM   int_system_parameter
                                          WHERE  active_flag = 1 AND name = 'PrintJob' ),
                                        @ReferenceDate ) ) )
    SET @TPJ =( SELECT COUNT(*)
                FROM   int_print_job ) - @PJ
    /* CEI */
    SET @CE =( SELECT COUNT(*)
               FROM   int_event_log
               WHERE  event_dt <
                      ( SELECT DATEADD( HOUR,
                                        ( SELECT Cast( parm_value AS INT ) * -1
                                          FROM   int_system_parameter
                                          WHERE  active_flag = 1 AND name = 'CEILog' ),
                                        @ReferenceDate ) ) )
    SET @TCE =( SELECT COUNT(*)
                FROM   int_event_log ) - @CE
    /* HL7 Success*/
    SET @HS =( SELECT COUNT(*)
               FROM   hl7_out_queue
               WHERE  msg_status = 'R' AND sent_dt <
                          ( SELECT DATEADD( HOUR,
                                            ( SELECT Cast( parm_value AS INT ) * -1
                                              FROM   int_system_parameter
                                              WHERE  active_flag = 1 AND name = 'HL7Success' ),
                                            @ReferenceDate ) ) )
    SET @THS =( SELECT COUNT(*)
                FROM   hl7_out_queue
                WHERE  msg_status = 'R' ) - @HS
    /* HL7 Error */
    SET @HE =( SELECT COUNT(*)
               FROM   hl7_out_queue
               WHERE  msg_status = 'E' AND sent_dt <
                          ( SELECT DATEADD( HOUR,
                                            ( SELECT Cast( parm_value AS INT ) * -1
                                              FROM   int_system_parameter
                                              WHERE  active_flag = 1 AND name = 'HL7Error' ),
                                            @ReferenceDate ) ) )
    SET @THE =( SELECT COUNT(*)
                FROM   hl7_out_queue
                WHERE  msg_status = 'E' ) - @HE
    /* HL7 Not Read*/
    SET @HN =( SELECT COUNT(*)
               FROM   hl7_out_queue
               WHERE  msg_status = 'N' AND sent_dt <
                          ( SELECT DATEADD( HOUR,
                                            ( SELECT Cast( parm_value AS INT ) * -1
                                              FROM   int_system_parameter
                                              WHERE  active_flag = 1 AND name = 'HL7NotRead' ),
                                            @ReferenceDate ) ) )
    SET @THN =( SELECT COUNT(*)
                FROM   hl7_out_queue
                WHERE  msg_status = 'N' ) - @HN
    /* HL7 Pending */
    SET @HP =( SELECT COUNT(*)
               FROM   hl7_out_queue
               WHERE  msg_status = 'P' AND sent_dt <
                          ( SELECT DATEADD( HOUR,
                                            ( SELECT Cast( parm_value AS INT ) * -1
                                              FROM   int_system_parameter
                                              WHERE  active_flag = 1 AND name = 'HL7Pending' ),
                                            @ReferenceDate ) ) )
    SET @THP =( SELECT COUNT(*)
                FROM   hl7_out_queue
                WHERE  msg_status = 'P' ) - @HP

    /* inform Results */

    SELECT @TMR AS VALIDMONITORRESULT,
           @MR AS EXPMONITORRESULT,
           @TWF AS VALIDEXPWAVEFORM,
           @WF AS EXPWAVEFORM,
           @TTL AS VALIDTWELVELEAD,
           @TL AS EXPTWELVELEAD,
           @TAL AS VALIDALARM,
           @AL AS EXPALARM,
           @TML AS VALIDMESSAGELOG,
           @ML AS EXPMESSAGELOG,
           @TPJ AS VALIDPRINTJOB,
           @PJ AS EXPPRINTJOB,
           @TCE AS VALIDCEI,
           @CE AS EXPCEI,
           @THS AS VALIDHL7SUCCESS,
           @HS AS EXPHL7SUCCESS,
           @THE AS VALIDHL7ERROR,
           @HE AS EXPHL7ERROR,
           @THN AS VALIDHL7NOTREAD,
           @HN AS EXPHL7NOTREAD,
           @THP AS VALIDHL7NOTREAD,
           @HP AS EXPHL7NOTREAD
  END


