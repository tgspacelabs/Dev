
CREATE PROCEDURE [dbo].[usp_HL7_GetObservationRequestData]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        [OrderNumber].[Value] [ORDER_ID],
        [send_app] AS [SENDING_APPLICATION],
        CAST(NULL AS DATETIME) [ORDER_DATE_TIME]
    FROM
        [dbo].[int_gateway],
        (SELECT
            [Value]
         FROM
            [dbo].[ApplicationSettings]
         WHERE
            [Key] = 'DefaultFillerOrderNumber'
        ) AS [OrderNumber];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetObservationRequestData';

