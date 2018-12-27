
/*[[Hl7_UpdateInboundMessageStatus]] is used to Update the Inbound Response message of type ADT and QRY*/
CREATE PROCEDURE [dbo].[usp_Hl7_UpdateInboundMessageStatus]
(
	@MessageStatus nchar(1),
	@MessageNo int 
)
AS
BEGIN
	UPDATE Hl7InboundMessage 
	SET MessageStatus = @MessageStatus,
	MessageProcessedDate=GETDATE() 
	WHERE MessageNo = @MessageNo
END

