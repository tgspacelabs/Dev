
CREATE PROCEDURE [dbo].[GetPatientSavedEventVitals]
  (
  @patient_id AS UNIQUEIDENTIFIER,
  @event_id   AS UNIQUEIDENTIFIER,
  @gds_code   AS NVARCHAR(80)
  )
AS
  BEGIN
    SELECT result_dt,
           result_value
    FROM   int_savedevent_vitals
    WHERE  patient_id = @patient_id AND event_id = @event_id AND gds_code = @gds_code
  END

