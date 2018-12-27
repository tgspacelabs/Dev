

CREATE PROCEDURE [dbo].[p_ml_Delete_Duplicate_Info]
    (
     @Duplicate_Monitor AS VARCHAR(5)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
        [dbo].[ml_duplicate_info]
    WHERE
        [Duplicate_Monitor] = @Duplicate_Monitor;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_ml_Delete_Duplicate_Info';

