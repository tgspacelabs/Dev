﻿
CREATE PROCEDURE [dbo].[usp_GetHL7LogListBoth]
    (
     @FromDate NVARCHAR(MAX),
     @ToDate NVARCHAR(MAX),
     @MessageNumber NVARCHAR(40) = NULL,
     @patientId NVARCHAR(40) = NULL,
     @MsgEventCode NCHAR(6) = NULL,
     @MsgEventType NCHAR(6) = NULL,
     @MsgSystem NVARCHAR(100) = NULL,
     @PatientVisitNo NVARCHAR(40) = NULL,
     @MsgStatusRead BIT,
     @MsgStatusError BIT,
     @MsgStatusNotProcessed BIT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @ADTQuery NVARCHAR(MAX),
        @SubQuery NVARCHAR(200);

    SET @ADTQuery = 'SELECT 
MessageQueuedDate AS Date,
HL7InboundMessage.MessageControlId AS HL7#, 
Hl7PatientLink.PatientMrn AS ''Patient ID'',
MessageStatus AS ''Status'', 
MessageSendingApplication AS ''Send System'', 
MessageTypeEventCode AS Event,
Hl7Message AS Message,
''I'' AS Direction 
FROM HL7InboundMessage
LEFT OUTER JOIN Hl7PatientLink
on Hl7PatientLink.MessageNo=HL7InboundMessage.MessageNo
WHERE MessageQueuedDate BETWEEN ';
    SET @ADTQuery = @ADTQuery + '''' + @FromDate + '''';
    SET @ADTQuery = @ADTQuery + ' AND ';
    SET @ADTQuery = @ADTQuery + '''' + @ToDate + '''';

    IF (@MessageNumber IS NOT NULL
        AND @MessageNumber <> ''
        )
        SET @ADTQuery = @ADTQuery + ' AND  HL7InboundMessage.MessageControlId=' + '''' + @MessageNumber + '''';

    IF (@patientId IS NOT NULL
        AND @patientId <> ''
        )
        SET @ADTQuery = @ADTQuery + ' AND  Hl7PatientLink.PatientMrn=' + '''' + @patientId + '''';

    IF (@MsgEventCode IS NOT NULL
        AND @MsgEventCode <> ''
        )
        SET @ADTQuery = @ADTQuery + ' AND  HL7InboundMessage.MessageTypeEventCode=' + '''' + @MsgEventCode + '''';

    IF (@MsgEventType IS NOT NULL
        AND @MsgEventType <> ''
        )
        SET @ADTQuery = @ADTQuery + ' AND  HL7InboundMessage.MessageType=' + '''' + @MsgEventType + '''';

    IF (@MsgSystem IS NOT NULL
        AND @MsgSystem <> ''
        )
        SET @ADTQuery = @ADTQuery + ' AND  HL7InboundMessage.MessageSendingApplication=' + '''' + @MsgSystem + '''';

    IF (@PatientVisitNo IS NOT NULL
        AND @PatientVisitNo <> ''
        )
        SET @ADTQuery = @ADTQuery + ' AND  Hl7PatientLink.PatientVisitNumber=' + '''' + @PatientVisitNo + '''';

    IF (@MsgStatusRead = 1
        OR @MsgStatusError = 1
        OR @MsgStatusNotProcessed = 1
        )
    BEGIN
        SET @ADTQuery = @ADTQuery + ' AND ';
        SET @SubQuery = '(';
        
        IF (@MsgStatusRead = 1)
        BEGIN
            SET @SubQuery = @SubQuery + ' HL7InboundMessage.MessageStatus=''R'' ';
        END;

        IF (@MsgStatusError = 1)
        BEGIN
            IF (LEN(@SubQuery) > 1)
                SET @SubQuery = @SubQuery + ' OR ';

            SET @SubQuery = @SubQuery + ' HL7InboundMessage.MessageStatus=''E'' ';
        END;
        
        IF (@MsgStatusNotProcessed = 1)
        BEGIN
            IF (LEN(@SubQuery) > 1)
                SET @SubQuery = @SubQuery + ' OR ';

            SET @SubQuery = @SubQuery + ' HL7InboundMessage.MessageStatus=''N'' ';
        END;
        
        SET @SubQuery = @SubQuery + ')';
        SET @ADTQuery = @ADTQuery + @SubQuery;
    END;

    SET @ADTQuery = @ADTQuery + ' UNION ';

    DECLARE
        @OruQuery NVARCHAR(MAX),
        @SubQueryORU NVARCHAR(200);

    SET @OruQuery = 'SELECT 
queued_dt AS Date, 
msg_no AS HL7#, 
patient_id AS ''Patient ID'',
msg_status AS Status,
msh_system AS ''Send System'', 
msh_event_cd AS Event,
ISNULL(hl7_text_short,
hl7_text_long) AS Message,
''O'' AS Direction
FROM hl7_out_queue 
WHERE queued_dt BETWEEN ';
    SET @OruQuery = @OruQuery + '''' + @FromDate + '''';
    SET @OruQuery = @OruQuery + ' AND ';
    SET @OruQuery = @OruQuery + '''' + @ToDate + '''';

    IF (@MessageNumber IS NOT NULL
        AND @MessageNumber <> ''
        )
        SET @OruQuery = @OruQuery + ' AND  msg_no=' + '''' + @MessageNumber + '''';

    IF (@patientId IS NOT NULL
        AND @patientId <> ''
        )
        SET @OruQuery = @OruQuery + ' AND  patient_id=' + '''' + @patientId + '''';

    IF (@MsgEventCode IS NOT NULL
        AND @MsgEventCode <> ''
        )
        SET @OruQuery = @OruQuery + ' AND  msh_event_cd=' + '''' + @MsgEventCode + '''';

    IF (@MsgEventType IS NOT NULL
        AND @MsgEventType <> ''
        )
        SET @OruQuery = @OruQuery + ' AND  msh_msg_type=' + '''' + @MsgEventType + '''';

    IF (@MsgSystem IS NOT NULL
        AND @MsgSystem <> ''
        )
        SET @OruQuery = @OruQuery + ' AND  msh_system=' + '''' + @MsgSystem + '''';

    IF (@MsgStatusRead = 1
        OR @MsgStatusError = 1
        OR @MsgStatusNotProcessed = 1
        )
    BEGIN
        SET @OruQuery = @OruQuery + ' AND ';
        SET @SubQueryORU = '(';

        IF (@MsgStatusRead = 1)
        BEGIN
            SET @SubQueryORU = @SubQueryORU + ' msg_status=''R'' ';
        END;

        IF (@MsgStatusError = 1)
        BEGIN
            IF (LEN(@SubQueryORU) > 1)
                SET @SubQueryORU = @SubQueryORU + ' OR ';

            SET @SubQueryORU = @SubQueryORU + ' msg_status=''E'' ';
        END;

        IF (@MsgStatusNotProcessed = 1)
        BEGIN
            IF (LEN(@SubQueryORU) > 1)
                SET @SubQueryORU = @SubQueryORU + ' OR ';

            SET @SubQueryORU = @SubQueryORU + ' msg_status=''N'' ';
        END;

        SET @SubQueryORU = @SubQueryORU + ')';
        SET @OruQuery = @OruQuery + @SubQueryORU;
    END;

    EXEC(@ADTQUERY + @OruQuery);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetHL7LogListBoth';
