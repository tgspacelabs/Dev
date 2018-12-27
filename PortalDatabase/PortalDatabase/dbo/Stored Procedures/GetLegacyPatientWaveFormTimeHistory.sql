CREATE PROCEDURE [dbo].[GetLegacyPatientWaveFormTimeHistory]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SELECT
        [start_ft],
        [start_dt]
    FROM
        [dbo].[int_waveform]
    WHERE
        [patient_id] = @patient_id
    ORDER BY
        [start_ft];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetLegacyPatientWaveFormTimeHistory';

