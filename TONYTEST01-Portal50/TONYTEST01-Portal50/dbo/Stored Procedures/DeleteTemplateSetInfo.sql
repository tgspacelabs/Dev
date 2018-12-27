
CREATE PROCEDURE [dbo].[DeleteTemplateSetInfo]
  (
  @UserID           DUSER_ID,
  @PatientID        DPATIENT_ID,
  @TemplateSetIndex INT
  )
AS
  BEGIN
    DELETE dbo.int_template_set_info
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND template_set_index = @TemplateSetIndex )

  END

