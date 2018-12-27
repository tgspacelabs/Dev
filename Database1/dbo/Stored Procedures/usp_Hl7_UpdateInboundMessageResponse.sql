

/*[Hl7_UpdateInboundMessageResponse] is used to Update status of inbound messages of type ADT and QRY*/
CREATE PROCEDURE [dbo].[usp_Hl7_UpdateInboundMessageResponse]
    (
     @MessageNo INT,
     @MessageResponse NVARCHAR(MAX)
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[Hl7InboundMessage]
    SET
        [Hl7MessageResponse] = @MessageResponse
    WHERE
        [MessageNo] = @MessageNo;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Update status of inbound messages of type ADT and QRY.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Hl7_UpdateInboundMessageResponse';

