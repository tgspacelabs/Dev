
-- =============================================
-- Author:		Syam
-- Create date: Apr - 16 - 2014
-- Description:	Retrieves the common order information for the given patient
-- =============================================
CREATE PROCEDURE [dbo].[usp_HL7_GetCommonOrderData]
AS
BEGIN
	SELECT TOP 1 
	OrderNumber.Value ORDER_ID, 
	send_app SENDING_APPLICATION, 
	OrderStatus.Value ORDER_STATUS, 
	cast(NULL AS DATETIME) ORDER_DATE_TIME
	FROM int_gateway,
	(SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderStatus') AS OrderStatus,
	(SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderNumber') AS OrderNumber
END
