/* TO link the Hl7InboundMessage table with Hl7 patients*/

/*Hl7_InsertInboundMessage is used to insert inbound messages of type ADT and QRY*/
CREATE PROCEDURE [dbo].[usp_Hl7_InsertInboundMessage]
(
	@MessageNo int output,
	@MessageStatus nchar(1),
	@Hl7Message NVARCHAR(MAX),
	@MessageSendingApplication NVARCHAR(180),
	@MessageSendingFacility NVARCHAR(180),
	@MessageType nchar(3), 
	@MessageTypeEventCode nchar(3), 
	@MessageControlId NVARCHAR(20),
	@MessageVersion NVARCHAR(60),
	@MessageHeaderDate datetime
)
AS
BEGIN
INSERT INTO Hl7InboundMessage
(
	 MessageStatus
	,Hl7Message
	,MessageSendingApplication
	,MessageSendingFacility
	,MessageType
	,MessageTypeEventCode
	,MessageControlId
	,MessageVersion
	,MessageHeaderDate
	,MessageQueuedDate
)
VALUES
(
	@MessageStatus,
	@Hl7Message,
	@MessageSendingApplication,
	@MessageSendingFacility,
	@MessageType, 
	@MessageTypeEventCode, 
	@MessageControlId,
	@MessageVersion,
	@MessageHeaderDate,
	GETDATE()
)
SET @MessageNo=SCOPE_IDENTITY();
END
