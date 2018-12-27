

/*[[Hl7_UpdateInboundMessageStatus]] is used to Update the Inbound Response message of type ADT and QRY*/
CREATE PROCEDURE [dbo].[usp_Hl7_UpdateInboundMessageStatus]
    (
     @MessageStatus NCHAR(1),
     @MessageNo INT 
    )
AS
BEGIN
    --SET NOCOUNT ON;

    UPDATE
        [dbo].[Hl7InboundMessage]
    SET
        [MessageStatus] = @MessageStatus,
        [MessageProcessedDate] = GETDATE()
    WHERE
        [MessageNo] = @MessageNo;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Update the Inbound Response message of type ADT and QRY.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Hl7_UpdateInboundMessageStatus';

