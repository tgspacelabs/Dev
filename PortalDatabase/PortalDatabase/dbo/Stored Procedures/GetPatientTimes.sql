CREATE PROCEDURE [dbo].[GetPatientTimes]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SELECT
        MIN([int_waveform].[start_ft]) AS [start_ft],
        MAX([int_waveform].[end_ft]) AS [end_ft]
    FROM
        [dbo].[int_waveform]
    WHERE
        [int_waveform].[patient_id] = @patient_id;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientTimes';

