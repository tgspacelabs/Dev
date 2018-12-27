

CREATE PROCEDURE [dbo].[DeleteBinInfo]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID,
     @TemplateSetIndex INT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
        [dbo].[int_bin_info]
    WHERE
        [user_id] = @UserID
        AND [patient_id] = @PatientID
        AND [template_set_index] = @TemplateSetIndex;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteBinInfo';

