
/*[usp_HL7_InsertHL7InboundMessage] used to insert Hl7 Ack Message*/
CREATE PROCEDURE usp_HL7_InsertHL7Ack
(
@msgControlId nchar(40),
@msgStatus nchar(20), 
@clientIP nchar(60), 
@ackMsgControlId nchar(40), 
@ackSystem nchar(100), 
@ackOrganization nchar(100)
)
AS
BEGIN
INSERT INTO 
hl7_msg_ack 
	(msg_control_id, msg_status, clientIP, ack_msg_control_id, ack_system, ack_organization, received_dt, num_retries) 
VALUES 
	(@msgControlId, @msgStatus, @clientIP, @ackMsgControlId, @ackSystem, @ackOrganization, getdate(), 0)
END
