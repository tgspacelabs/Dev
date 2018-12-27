

/*usp_HL7_InsertHL7OutMessage used to inser the Hl7 out bound message*/
CREATE PROCEDURE [dbo].usp_HL7_InsertHL7OutMessage
(
@msg_no char(20),
@msg_status nchar(20),
@hl7_text_long NVARCHAR(MAX),
@patient_id NVARCHAR(120),
@msh_system NVARCHAR(100),
@msh_organization nchar(100),
@msh_event_cd nchar(20),
@msh_msg_type nchar(20),
@realQueryVitalDT datetime
)
AS
BEGIN
	INSERT INTO 
	hl7_out_queue 
		(msg_no,msg_status, hl7_text_long, patient_id, msh_system, msh_organization, msh_event_cd, msh_msg_type, queued_dt) 
	VALUES 
		(@msg_no,@msg_status, @hl7_text_long, @patient_id, @msh_system, @msh_organization, @msh_event_cd, @msh_msg_type, @realQueryVitalDT)
END
