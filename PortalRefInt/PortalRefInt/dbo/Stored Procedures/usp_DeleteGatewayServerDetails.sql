﻿CREATE PROCEDURE [dbo].[usp_DeleteGatewayServerDetails]
    (
     @gatewayID BIGINT
    )
AS
BEGIN
    DELETE FROM
        [dbo].[int_gateway_server]
    WHERE
        [gateway_id] = @gatewayID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DeleteGatewayServerDetails';

