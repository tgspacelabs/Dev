
CREATE PROCEDURE [dbo].[usp_HL7_GetObservationRequestData]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN
		SELECT DISTINCT
		OrderNumber.Value ORDER_ID, 
		send_app AS SENDING_APPLICATION, 
		cast(NULL AS DATETIME) ORDER_DATE_TIME
		FROM int_gateway,
		(SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderNumber') AS OrderNumber
	END
	SET NOCOUNT OFF;
END
