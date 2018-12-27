
CREATE PROCEDURE [dbo].[RetrieveBinInfo]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID,
     @TemplateSetIndex INT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [user_id],
        [patient_id],
        [template_set_index],
        [template_index],
        [bin_number],
        [source],
        [beat_count],
        [first_beat_number],
        [non_ignored_count],
        [first_non_ignored_beat],
        [iso_offset],
        [st_offset],
        [i_point],
        [j_point],
        [st_class],
        [singles_bin],
        [edit_bin],
        [subclass_number],
        [bin_image]
    FROM
        [dbo].[int_bin_info]
    WHERE
        ([user_id] = @UserID
        AND [patient_id] = @PatientID
        AND [template_set_index] = @TemplateSetIndex
        );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'RetrieveBinInfo';

