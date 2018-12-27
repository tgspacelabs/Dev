
CREATE PROCEDURE [dbo].[RetrieveBinInfo]
  (
  @UserID           DUSER_ID,
  @PatientID        DPATIENT_ID,
  @TemplateSetIndex INT
  )
AS
  BEGIN
    SELECT USER_ID,
           patient_id,
           template_set_index,
           template_index,
           bin_number,
           source,
           beat_count,
           first_beat_number,
           non_ignored_count,
           first_non_ignored_beat,
           iso_offset,
           st_offset,
           i_point,
           j_point,
           st_class,
           singles_bin,
           edit_bin,
           subclass_number,
           bin_image
    FROM   dbo.int_bin_info
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND template_set_index = @TemplateSetIndex )
  END

