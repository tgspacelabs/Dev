

CREATE PROCEDURE [dbo].[p_cb_Get_Encounter_Id]
    (
     @PatientID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_encounter_map].[encounter_id],
        [code] AS [CLASS_CD],
        [admit_dt],
        [begin_dt],
        [discharge_dt],
        [int_encounter].[status_cd]
    FROM
        [dbo].[int_encounter]
        LEFT OUTER JOIN [dbo].[int_misc_code] ON ([patient_class_cid] = [code_id])
        INNER JOIN [dbo].[int_encounter_map] ON ([int_encounter].[encounter_id] = [int_encounter_map].[encounter_id])
    WHERE
        ([int_encounter_map].[patient_id] = @PatientID);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Get_Encounter_Id';

