
CREATE PROCEDURE [dbo].[p_ml_Delete_Duplicate_Info]
  (
  @Duplicate_Monitor AS VARCHAR(5)
  )
AS
  BEGIN
    DELETE dbo.ml_duplicate_info
    WHERE  Duplicate_Monitor = @Duplicate_Monitor
  END

