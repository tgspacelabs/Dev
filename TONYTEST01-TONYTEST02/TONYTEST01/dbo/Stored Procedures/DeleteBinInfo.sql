
CREATE PROCEDURE [dbo].[DeleteBinInfo]
  (
  @UserID           DUSER_ID,
  @PatientID        DPATIENT_ID,
  @TemplateSetIndex INT
  )
AS
  BEGIN
    DELETE dbo.int_bin_info
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND template_set_index = @TemplateSetIndex )
  END

