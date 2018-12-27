CREATE PROCEDURE [dbo].[usp_GetHL7LogListInbound]
(
@FromDate NVARCHAR(MAX),
@ToDate NVARCHAR(MAX),
@MessageNumber NVARCHAR(40)=null,
@patientId NVARCHAR(40)=null,
@MsgEventCode nchar(6)=null,
@MsgEventType nchar(6)=null,
@MsgSystem NVARCHAR(100)=null,
@PatientVisitNo NVARCHAR(40)=null,
@MsgStatusRead bit, 
@MsgStatusError bit,
@MsgStatusNotProcessed bit
)
AS
BEGIN

DECLARE @ADTQuery NVARCHAR(MAX),@SubQuery NVARCHAR(200)
SET @ADTQuery='SELECT 
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
WHERE MessageQueuedDate BETWEEN '
SET @ADTQuery = @ADTQuery + '''' + @FromDate + ''''
SET @ADTQuery = @ADTQuery +' AND '
SET @ADTQuery = @ADTQuery + '''' + @ToDate + ''''
if(@MessageNumber IS NOT NULL AND @messageNumber<>'')
	SET @ADTQuery = @ADTQuery +' AND  HL7InboundMessage.MessageControlId='+''''+@MessageNumber +''''
if(@patientId IS NOT NULL AND @patientId<>'')
	SET @ADTQuery = @ADTQuery +' AND  Hl7PatientLink.PatientMrn='+''''+@patientId +''''
if(@MsgEventCode IS NOT NULL AND @MsgEventCode<>'')
	SET @ADTQuery=@ADTQuery +' AND  HL7InboundMessage.MessageTypeEventCode='+''''+@MsgEventCode +''''
if(@MsgEventType IS NOT NULL AND @MsgEventType<>'')
	SET @ADTQuery=@ADTQuery +' AND  HL7InboundMessage.MessageType='+''''+@MsgEventType +''''
if(@MsgSystem IS NOT NULL AND @MsgSystem<>'')
	SET @ADTQuery=@ADTQuery +' AND  HL7InboundMessage.MessageSendingApplication='+''''+@MsgSystem +''''
if(@PatientVisitNo IS NOT NULL AND @PatientVisitNo<>'')
	SET @ADTQuery=@ADTQuery +' AND  Hl7PatientLink.PatientVisitNumber='+''''+@PatientVisitNo +''''
if(@MsgStatusRead=1 OR @MsgStatusError=1 OR @MsgStatusNotProcessed=1)
BEGIN
SET @ADTQuery=@ADTQuery + ' AND '
SET @SubQuery='('
IF(@MsgStatusRead=1)
	BEGIN
		SET @SubQuery=@SubQuery +' HL7InboundMessage.MessageStatus=''R'' '
	END
IF(@MsgStatusError=1)
	BEGIN
		if(LEN(@SubQuery)>1) SET @SubQuery=@SubQuery +' OR '
		SET @SubQuery=@SubQuery +' HL7InboundMessage.MessageStatus=''E'' '
	END
IF(@MsgStatusNotProcessed=1)
	BEGIN
		if(LEN(@SubQuery)>1) SET @SubQuery=@SubQuery +' OR '
		SET @SubQuery=@SubQuery +' HL7InboundMessage.MessageStatus=''N'' '
	END
SET @SubQuery=@SubQuery +')'
SET @ADTQuery=@ADTQuery+@SubQuery
END
EXEC(@ADTQuery)

END
