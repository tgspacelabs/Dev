------------------------------------------------------

CREATE PROCEDURE [dbo].[GetPatientSavedEventVitalsNew]
  (
  @patient_id AS UNIQUEIDENTIFIER,
  @event_id   AS UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT result_dt,
           result_value,
           gds_code
    FROM   int_savedevent_vitals
    WHERE  patient_id = @patient_id AND event_id = @event_id
END
