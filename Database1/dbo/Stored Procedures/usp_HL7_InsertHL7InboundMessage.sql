
/*[usp_HL7_InsertHL7InboundMessage] used to insert Hl7 inbound message*/
CREATE PROCEDURE [dbo].[usp_HL7_InsertHL7InboundMessage]
    (
     @msg_status NCHAR(2),
     @msh_msg_type NCHAR(6),
     @msh_event_cd NCHAR(6),
     @msh_organization NVARCHAR(72),
     @msh_system NVARCHAR(72),
     @msh_dt DATETIME,
     @msh_control_id NVARCHAR(72),
     @msh_version NVARCHAR(10),
     @Hl7TextShort NVARCHAR(510) = NULL,
     @Hl7TextLong NVARCHAR(MAX) = NULL,
     @msg_no NUMERIC(9) OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF (@Hl7TextShort IS NOT NULL)
    BEGIN
        INSERT  INTO [dbo].[hl7_in_queue]
                ([msg_status],
                 [queued_dt],
                 [msh_msg_type],
                 [msh_event_cd],
                 [msh_organization],
                 [msh_system],
                 [msh_dt],
                 [msh_control_id],
                 [msh_version],
                 [hl7_text_short]
                )
        VALUES
                (@msg_status,
                 GETDATE(),
                 @msh_msg_type,
                 @msh_event_cd,
                 @msh_organization,
                 @msh_system,
                 @msh_dt,
                 @msh_control_id,
                 @msh_version,
                 @Hl7TextShort
                );
			
    END;
    ELSE
    BEGIN
        INSERT  INTO [dbo].[hl7_in_queue]
                ([msg_status],
                 [queued_dt],
                 [msh_msg_type],
                 [msh_event_cd],
                 [msh_organization],
                 [msh_system],
                 [msh_dt],
                 [msh_control_id],
                 [msh_version],
                 [hl7_text_long]
                )
        VALUES
                (@msg_status,
                 GETDATE(),
                 @msh_msg_type,
                 @msh_event_cd,
                 @msh_organization,
                 @msh_system,
                 @msh_dt,
                 @msh_control_id,
                 @msh_version,
                 @Hl7TextLong
                );  
			
    END;
    SET @msg_no = SCOPE_IDENTITY();
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insert HL7 inbound message', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_InsertHL7InboundMessage';

