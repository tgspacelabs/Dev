

CREATE PROCEDURE [dbo].[GetvsvAccess]
    (
     @patient_monitor_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        1
    FROM
        [dbo].[int_patient_monitor] [PM]
        INNER JOIN [dbo].[int_monitor] [M] ON [M].[monitor_id] = [PM].[monitor_id]
                                        AND [PM].[patient_monitor_id] = @patient_monitor_id
        INNER JOIN [dbo].[int_product_access] [PA] ON [PA].[organization_id] = [M].[unit_org_id]
                                                AND [PA].[product_cd] = 'vsv';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetvsvAccess';

