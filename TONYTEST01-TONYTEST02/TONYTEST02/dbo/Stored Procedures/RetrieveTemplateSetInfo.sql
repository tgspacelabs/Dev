
CREATE PROCEDURE [dbo].[RetrieveTemplateSetInfo]
  (
  @UserID           DUSER_ID,
  @PatientID        DPATIENT_ID,
  @TemplateSetIndex INT
  )
AS
  BEGIN
    SELECT user_id,
           patient_id,
           template_set_index,
           lead_one,
           lead_two,
           number_of_bins,
           number_of_templates
    FROM   dbo.int_template_set_info
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND template_set_index = @TemplateSetIndex )
  END


