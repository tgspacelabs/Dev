
CREATE PROCEDURE [dbo].[p_hl7_Status]
AS
  DECLARE
    @outbound_sent   INT,
    @outbound_toproc INT,
    @outbound_cnt    INT,
    @msg             VARCHAR(255)

  SELECT @outbound_sent = COUNT(*)
  FROM   hl7_out_queue
  WHERE  sent_dt IS NOT NULL

  SELECT @outbound_toproc = COUNT(*)
  FROM   hl7_out_queue
  WHERE  sent_dt IS NULL

  SELECT @outbound_cnt = COUNT(*)
  FROM   int_outbound_queue
  WHERE  processed_dt IS NULL

  PRINT 'Current Date/Time: ' + CONVERT( VARCHAR(50), GetDate( ), 20 )

  PRINT ''

  SET @msg = 'Total Outbound Messages Sent: ' + CONVERT( VARCHAR(50), @outbound_sent )

  PRINT @msg

  SET @msg = 'Total Outbound Messages not sent: ' + CONVERT( VARCHAR(50), @outbound_toproc )

  PRINT @msg

  SET @msg = 'Total Outbound Results to Process: ' + CONVERT( VARCHAR(50), @outbound_cnt )

  PRINT @msg

  PRINT ''

  SET ROWCOUNT 50

  PRINT 'Last 50 Log Messages'

  SELECT msg_dt,
         msg_text
  FROM   int_msg_log
  ORDER  BY msg_dt DESC

