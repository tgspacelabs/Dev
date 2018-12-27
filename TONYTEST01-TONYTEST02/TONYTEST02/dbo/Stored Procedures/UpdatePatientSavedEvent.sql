
CREATE PROCEDURE [dbo].[UpdatePatientSavedEvent]
  (
  @patient_id UNIQUEIDENTIFIER,
  @event_id   UNIQUEIDENTIFIER,
  @title      DTITLE,
  @comment    DCOMMENT
  )
AS
  BEGIN
    UPDATE int_savedEvent
    SET    title = @title,
           comment = @comment
    WHERE  ( patient_id = @patient_id AND event_id = @event_id )
  END


