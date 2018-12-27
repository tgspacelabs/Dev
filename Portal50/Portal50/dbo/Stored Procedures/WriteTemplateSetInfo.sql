
CREATE PROCEDURE [dbo].[WriteTemplateSetInfo]
  (
  @UserID            DUSER_ID,
  @PatientID         DPATIENT_ID,
  @TemplateSetIndex  INT,
  @LeadOne           INT,
  @LeadTwo           INT,
  @NumberOfBins      INT,
  @NumberOfTemplates INT
  )
AS
  BEGIN
    INSERT INTO dbo.int_template_set_info
                (user_id,
                 patient_id,
                 template_set_index,
                 lead_one,
                 lead_two,
                 number_of_bins,
                 number_of_templates)
    VALUES      (@UserID,
                 @PatientID,
                 @TemplateSetIndex,
                 @LeadOne,
                 @LeadTwo,
                 @NumberOfBins,
                 @NumberOfTemplates)
  END

