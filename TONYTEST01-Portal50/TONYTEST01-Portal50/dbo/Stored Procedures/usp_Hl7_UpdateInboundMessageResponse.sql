
/*[Hl7_UpdateInboundMessageResponse] is used to Update status of inbound messages of type ADT and QRY*/
CREATE PROCEDURE [dbo].[usp_Hl7_UpdateInboundMessageResponse]
(
	@MessageNo INT,
	@MessageResponse NVARCHAR(MAX)
)
AS
BEGIN
	UPDATE Hl7InboundMessage
	SET Hl7MessageResponse=@MessageResponse 
	WHERE MessageNo=@MessageNo
END
