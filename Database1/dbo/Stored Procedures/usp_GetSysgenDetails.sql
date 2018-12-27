
CREATE PROCEDURE [dbo].[usp_GetSysgenDetails]
    (
     @product_cd VARCHAR(25)
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [product_cd],
        [feature_cd],
        [setting]
    FROM
        [dbo].[int_sysgen]
    WHERE
        [product_cd] = @product_cd
    ORDER BY
        [feature_cd];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetSysgenDetails';

