
CREATE PROCEDURE [dbo].[GetPatientTimes]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT mIn( int_waveform.start_ft ) AS START_FT,
           Max( int_waveform.end_ft ) AS END_FT
    FROM   dbo.int_waveform
    WHERE  ( int_waveform.patient_id = @patient_id )
  END


