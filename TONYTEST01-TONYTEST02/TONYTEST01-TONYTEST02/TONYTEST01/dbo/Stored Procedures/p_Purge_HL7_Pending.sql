﻿
CREATE PROCEDURE [dbo].[p_Purge_HL7_Pending]
(
    @FChunkSize INT,
    @PurgeDate DATETIME,
    @HL7PendingDataPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    /* HL7 PENDING */
    /* Fix for CR #2676 by Nancy on 1/16/08, Fail to purge due to sent_dt is null */
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[int_msg_log]
        FROM   [dbo].[hl7_out_queue]
        WHERE  msg_no = external_id AND msg_status = 'P' AND ( sent_dt < @PurgeDate OR queued_dt < @PurgeDate );

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[hl7_msg_ack]
        FROM   [dbo].[hl7_out_queue] HL7OQ
        WHERE  hl7_msg_ack.msg_control_id = HL7OQ.msg_no AND HL7OQ.msg_status = 'P' AND ( HL7OQ.sent_dt < @PurgeDate OR HL7OQ.queued_dt < @PurgeDate );

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[int_msg_log]
        WHERE  external_id IN
                ( SELECT CONVERT( VARCHAR(20), MessageNo )
                    FROM   [dbo].[Hl7InboundMessage]
                    WHERE  MessageStatus = 'P' AND MessageProcessedDate < @PurgeDate );

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[hl7_out_queue]
        WHERE msg_status = 'P' AND (sent_dt < @PurgeDate OR queued_dt < @PurgeDate);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[Hl7PatientLink]
        WHERE MessageNo IN (
            SELECT MessageNo 
            FROM Hl7InboundMessage 
            WHERE MessageStatus = 'P' 
                AND MessageProcessedDate < @PurgeDate);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[Hl7InboundMessage]
        WHERE MessageStatus = 'P' AND MessageProcessedDate < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @HL7PendingDataPurged = @RC;
END
