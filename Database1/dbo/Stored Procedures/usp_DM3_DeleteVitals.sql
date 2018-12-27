
CREATE PROCEDURE [dbo].[usp_DM3_DeleteVitals]
    (
     @COLLECTDATE NVARCHAR(30)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
        [dbo].[int_vital_live]
    WHERE
        [collect_dt] < @COLLECTDATE;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_DeleteVitals';

