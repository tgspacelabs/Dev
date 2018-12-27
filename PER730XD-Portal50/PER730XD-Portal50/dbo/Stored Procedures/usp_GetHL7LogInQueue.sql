CREATE PROCEDURE [dbo].[usp_GetHL7LogInQueue]
(
@msg_no NVARCHAR(40)
)
AS
BEGIN
    SELECT Hl7Message AS Message FROM HL7InboundMessage where MessageControlId=@msg_no
END
