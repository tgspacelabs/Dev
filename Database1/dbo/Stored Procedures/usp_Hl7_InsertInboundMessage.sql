
/* TO link the Hl7InboundMessage table with Hl7 patients*/

/*Hl7_InsertInboundMessage is used to insert inbound messages of type ADT and QRY*/
CREATE PROCEDURE [dbo].[usp_Hl7_InsertInboundMessage]
    (
     @MessageNo INT OUTPUT,
     @MessageStatus NCHAR(1),
     @Hl7Message NVARCHAR(MAX),
     @MessageSendingApplication NVARCHAR(180),
     @MessageSendingFacility NVARCHAR(180),
     @MessageType NCHAR(3),
     @MessageTypeEventCode NCHAR(3),
     @MessageControlId NVARCHAR(20),
     @MessageVersion NVARCHAR(60),
     @MessageHeaderDate DATETIME
    )
AS
BEGIN
    --SET NOCOUNT ON;

    INSERT  INTO [dbo].[Hl7InboundMessage]
            ([MessageStatus],
             [Hl7Message],
             [MessageSendingApplication],
             [MessageSendingFacility],
             [MessageType],
             [MessageTypeEventCode],
             [MessageControlId],
             [MessageVersion],
             [MessageHeaderDate],
             [MessageQueuedDate]
            )
    VALUES
            (@MessageStatus,
             @Hl7Message,
             @MessageSendingApplication,
             @MessageSendingFacility,
             @MessageType,
             @MessageTypeEventCode,
             @MessageControlId,
             @MessageVersion,
             @MessageHeaderDate,
             GETDATE()
            );
    SET @MessageNo = SCOPE_IDENTITY();
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'To link the HL7InboundMessage table with HL7 patients.  HL7_InsertInboundMessage is used to insert inbound messages of type ADT and QRY.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Hl7_InsertInboundMessage';

