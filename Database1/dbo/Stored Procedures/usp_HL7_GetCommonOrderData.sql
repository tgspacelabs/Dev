

-- =============================================
-- Author:		Syam
-- Create date: Apr - 16 - 2014
-- Description:	Retrieves the common order information for the given patient
-- =============================================
CREATE PROCEDURE [dbo].[usp_HL7_GetCommonOrderData]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        [OrderNumber].[Value] [ORDER_ID],
        [send_app] [SENDING_APPLICATION],
        [OrderStatus].[Value] [ORDER_STATUS],
        CAST(NULL AS DATETIME) [ORDER_DATE_TIME]
    FROM
        [dbo].[int_gateway],
        (SELECT
            [Value]
         FROM
            [dbo].[ApplicationSettings]
         WHERE
            [Key] = 'DefaultFillerOrderStatus'
        ) AS [OrderStatus],
        (SELECT
            [Value]
         FROM
            [dbo].[ApplicationSettings]
         WHERE
            [Key] = 'DefaultFillerOrderNumber'
        ) AS [OrderNumber];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves the common order information for the given patient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetCommonOrderData';

