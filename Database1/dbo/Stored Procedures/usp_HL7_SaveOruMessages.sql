

-- =============================================
-- Author:		SyamB
-- Create date: 16-05-2014
-- Description:	Retrieves the legacy Gds codes
-- =============================================
/*usp_HL7_InsertHL7OutMessage used to inser the Hl7 out bound message*/
CREATE PROCEDURE [dbo].[usp_HL7_SaveOruMessages]
    (
     @messageList [dbo].[OruMessages] READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[hl7_out_queue]
    SELECT
        [msg_status],
        [msg_no],
        [hl7_text_long],
        [hl7_text_short],
        [patient_id],
        [msh_system],
        [msh_organization],
        [msh_event_cd],
        [msh_msg_type],
        [sent_dt],
        [queued_dt]
    FROM
        @messageList;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves the legacy Gds codes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_SaveOruMessages';

