


/*usp_HL7_InsertHL7OutMessage used to inser the Hl7 out bound message*/
CREATE PROCEDURE [dbo].[usp_HL7_InsertHL7OutMessage]
    (
     @msg_no CHAR(20),
     @msg_status NCHAR(20),
     @hl7_text_long NVARCHAR(MAX),
     @patient_id NVARCHAR(120),
     @msh_system NVARCHAR(100),
     @msh_organization NCHAR(100),
     @msh_event_cd NCHAR(20),
     @msh_msg_type NCHAR(20),
     @realQueryVitalDT DATETIME
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[hl7_out_queue]
            ([msg_no],
             [msg_status],
             [hl7_text_long],
             [patient_id],
             [msh_system],
             [msh_organization],
             [msh_event_cd],
             [msh_msg_type],
             [queued_dt]
            )
    VALUES
            (@msg_no,
             @msg_status,
             @hl7_text_long,
             @patient_id,
             @msh_system,
             @msh_organization,
             @msh_event_cd,
             @msh_msg_type,
             @realQueryVitalDT
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insert the HL7 outbound message.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_InsertHL7OutMessage';

