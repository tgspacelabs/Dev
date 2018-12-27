
/*[usp_HL7_InsertHL7InboundMessage] used to insert Hl7 Ack Message*/
CREATE PROCEDURE [dbo].[usp_HL7_InsertHL7Ack]
    (
     @msgControlId NCHAR(40),
     @msgStatus NCHAR(20),
     @clientIP NCHAR(60),
     @ackMsgControlId NCHAR(40),
     @ackSystem NCHAR(100),
     @ackOrganization NCHAR(100)
    )
AS
BEGIN
    --SET NOCOUNT ON;

    INSERT  INTO [dbo].[hl7_msg_ack]
            ([msg_control_id],
             [msg_status],
             [clientIP],
             [ack_msg_control_id],
             [ack_system],
             [ack_organization],
             [received_dt],
             [num_retries]
            )
    VALUES
            (@msgControlId,
             @msgStatus,
             @clientIP,
             @ackMsgControlId,
             @ackSystem,
             @ackOrganization,
             GETDATE(),
             0
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insert HL7 Ack Message.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_InsertHL7Ack';

