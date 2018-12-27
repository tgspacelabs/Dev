CREATE PROCEDURE [dbo].[GetPatientTimeOfDay]
    (
     @patient_id UNIQUEIDENTIFIER,
     @start_ft BIGINT
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
        AND @start_ft >= [start_ft]
        AND @start_ft <= [end_ft]
    ORDER BY
        [start_ft];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientTimeOfDay';

