
CREATE PROCEDURE [dbo].[usp_DL_ETR_GetGatewaySettings]
    (
     @GatewayType NVARCHAR(10)
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS ( SELECT
                    *
                FROM
                    [sys].[all_objects]
                WHERE
                    [name] = 'int_DataLoader_ETR_Temp_Settings' )
    BEGIN
        SELECT
            [gateway_id],
            [gateway_type],
            [farm_name],
            [network],
            [et_do_not_store_waveforms],
            [include_trans_chs],
            [exclude_trans_chs],
            [et_print_alarms]
        FROM
            [int_DataLoader_ETR_Temp_Settings]
        WHERE
            [gateway_type] = @GatewayType
        ORDER BY
            [network];
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DL_ETR_GetGatewaySettings';

