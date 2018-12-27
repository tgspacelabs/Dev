
CREATE PROCEDURE [dbo].[GetLegacyPatientWaveFormTimeHistory] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN
      SELECT 
        [start_ft], 
        [start_dt]
      FROM 
        [dbo].[int_waveform] 
      WHERE 
        [patient_id] = @patient_id                
  ORDER BY [start_ft]
END
