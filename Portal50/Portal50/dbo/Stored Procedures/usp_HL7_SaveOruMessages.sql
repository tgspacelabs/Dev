
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
	
	INSERT INTO hl7_out_queue SELECT * FROM @messageList
END

