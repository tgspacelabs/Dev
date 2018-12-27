
CREATE PROCEDURE [dbo].[p_Purge_HL7_Success]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @hl7SuccessRowsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    /* HL7 SUCCESS */
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[int_msg_log]
        FROM
            [dbo].[hl7_out_queue]
        WHERE
            [msg_no] = [external_id]
            AND [msg_status] = N'R'
            AND [sent_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[hl7_msg_ack]
        FROM
            [dbo].[hl7_out_queue] [HL7OQ]
        WHERE
            [msg_control_id] = [HL7OQ].[msg_no]
            AND [HL7OQ].[msg_status] = N'R'
            AND [HL7OQ].[sent_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[int_msg_log]
        WHERE
            [external_id] IN (SELECT
                                CONVERT(VARCHAR(20), [MessageNo])
                              FROM
                                [dbo].[Hl7InboundMessage]
                              WHERE
                                [MessageStatus] = N'R'
                                AND [MessageProcessedDate] < @PurgeDate);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[hl7_out_queue]
        WHERE
            [msg_status] = N'R'
            AND [sent_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[Hl7PatientLink]
        WHERE
            [Hl7PatientLink].[MessageNo] IN (SELECT
                                                [MessageNo]
                                             FROM
                                                [dbo].[Hl7InboundMessage]
                                             WHERE
                                                [MessageStatus] = N'R'
                                                AND [MessageProcessedDate] < @PurgeDate);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[Hl7InboundMessage]
        WHERE
            [MessageStatus] = N'R'
            AND [MessageProcessedDate] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @hl7SuccessRowsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_HL7_Success';

