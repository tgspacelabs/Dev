
CREATE PROCEDURE [dbo].[usp_GetHL7LogList]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [MessageQueuedDate] AS [Date],
        [MessageControlId] AS [HL7#],
        [PatientMrn] AS [Patient ID],
        [MessageStatus] AS [Status],
        [MessageSendingApplication] AS [Send System],
        [MessageTypeEventCode] AS [Event],
        [Hl7Message] AS [Message],
        'I' AS [Direction]
    FROM
        [dbo].[Hl7InboundMessage]
        LEFT OUTER JOIN [dbo].[Hl7PatientLink] ON [Hl7PatientLink].[MessageNo] = [Hl7InboundMessage].[MessageNo]
    UNION
    SELECT
        [queued_dt] AS [Date],
        [msg_no] AS [HL7#],
        [patient_id] AS [Patient ID],
        [msg_status] AS [Status],
        [msh_system] AS [Send System],
        [msh_event_cd] AS [Event],
        ISNULL([hl7_text_short], [hl7_text_long]) AS [Message],
        'O' AS [Direction]
    FROM
        [dbo].[hl7_out_queue];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetHL7LogList';

