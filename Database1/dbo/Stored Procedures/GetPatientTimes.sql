

CREATE PROCEDURE [dbo].[GetPatientTimes]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MIN([start_ft]) AS [START_FT],
        MAX([end_ft]) AS [END_FT]
    FROM
        [dbo].[int_waveform]
    WHERE
        ([patient_id] = @patient_id);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientTimes';

