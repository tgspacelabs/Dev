CREATE PROCEDURE [dbo].[usp_GetHL7LogList]
AS
  BEGIN
	 SELECT 
	MessageQueuedDate AS Date,
	HL7InboundMessage.MessageControlId AS HL7#,
	HL7PatientLink.patientMrn AS 'Patient ID',
	MessageStatus AS Status,
	MessageSendingApplication AS 'Send System', 
	MessageTypeEventCode AS Event,
	Hl7Message AS Message,
	'I' AS Direction 
	FROM HL7InboundMessage
	LEFT OUTER JOIN HL7PatientLink
		ON HL7PatientLink.MessageNo=HL7InboundMessage.MessageNo

	UNION 

	SELECT 
	queued_dt AS Date,
	msg_no AS HL7#, 
	patient_id AS 'Patient ID',
	msg_status AS Status,
	msh_system AS 'Send System',
	msh_event_cd AS Event,
	ISNULL(hl7_text_short, hl7_text_long) AS Message,
	'O' AS Direction 
	FROM hl7_out_queue
  END
