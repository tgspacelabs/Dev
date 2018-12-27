


CREATE PROCEDURE [dbo].[p_gts_Purge_gts_Tables] (@Days AS INT = 15)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExpirationDate AS DATETIME;

    SET DEADLOCK_PRIORITY LOW;

    IF @Days IS NULL
        SET @Days = 15;

    SET @ExpirationDate = DATEADD(DAY, -(@Days), GETDATE( ));

    DELETE
        [dbo].[gts_waveform_index_rate]
    WHERE
        [period_start] < @ExpirationDate;

    DELETE
        [dbo].[gts_input_rate]
    WHERE
        [period_start] < @ExpirationDate;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_gts_Purge_gts_Tables';

