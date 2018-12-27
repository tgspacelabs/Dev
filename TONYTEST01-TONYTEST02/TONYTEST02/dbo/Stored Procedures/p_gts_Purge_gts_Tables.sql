

CREATE PROCEDURE [dbo].[p_gts_Purge_gts_Tables]
  (
  @Days AS INT = 15
  )
AS
  BEGIN
    DECLARE @ExpirationDate AS DATETIME

    SET DEADLOCK_PRIORITY LOW

    IF @Days IS NULL
      SET @Days = 15

    SET @ExpirationDate = DATEADD( DAY, -( @Days ), GetDate( ) )

    DELETE dbo.gts_waveform_index_rate
    WHERE  period_start < @ExpirationDate

    DELETE dbo.gts_input_rate
    WHERE  period_start < @ExpirationDate
  END


