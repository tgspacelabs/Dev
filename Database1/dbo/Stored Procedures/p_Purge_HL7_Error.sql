
CREATE PROCEDURE [dbo].[p_Purge_HL7_Error]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @hl7ErrorRowsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    /* HL7 ERROR */
    /* Fix for CR #2676 by Nancy on 1/16/08, Fail to purge due to sent_dt is null */
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[int_msg_log]
        FROM
            [dbo].[hl7_out_queue] AS [HL7OQ]
        WHERE
            [HL7OQ].[msg_no] = [external_id]
            AND [HL7OQ].[msg_status] = N'E'
            AND ([HL7OQ].[sent_dt] < @PurgeDate
            OR [HL7OQ].[queued_dt] < @PurgeDate
            );

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[hl7_msg_ack]
        FROM
            [dbo].[hl7_out_queue] AS [HL7OQ]
        WHERE
            [msg_control_id] = [HL7OQ].[msg_no]
            AND [HL7OQ].[msg_status] = N'E'
            AND ([HL7OQ].[sent_dt] < @PurgeDate
            OR [HL7OQ].[queued_dt] < @PurgeDate
            );

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [iml]
        FROM
            [dbo].[int_msg_log] AS [iml]
        WHERE
            [iml].[external_id] IN (SELECT
                                        CONVERT(VARCHAR(20), [MessageNo])
                                    FROM
                                        [dbo].[HL7InboundMessage]
                                    WHERE
                                        [MessageStatus] = N'E'
                                        AND [MessageQueuedDate] < @PurgeDate);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [hoq]
        FROM
            [dbo].[hl7_out_queue] AS [hoq]
        WHERE
            [hoq].[msg_status] = N'E'
            AND ([hoq].[sent_dt] < @PurgeDate
            OR [hoq].[queued_dt] < @PurgeDate
            );

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [hpl]
        FROM
            [dbo].[HL7PatientLink] AS [hpl]
        WHERE
            [hpl].[MessageNo] IN (SELECT
                                    [MessageNo]
                                  FROM
                                    [dbo].[HL7InboundMessage]
                                  WHERE
                                    [MessageStatus] = N'E'
                                    AND [MessageQueuedDate] < @PurgeDate);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [him]
        FROM
            [dbo].[HL7InboundMessage] AS [him]
        WHERE
            [him].[MessageStatus] = N'E'
            AND [him].[MessageQueuedDate] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @hl7ErrorRowsPurged = @RC;
END;
