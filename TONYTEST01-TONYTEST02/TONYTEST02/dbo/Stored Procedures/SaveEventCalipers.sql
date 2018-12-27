
CREATE PROCEDURE [dbo].[SaveEventCalipers]
  @patient_id           UNIQUEIDENTIFIER,
  @event_id             UNIQUEIDENTIFIER,
  @channel_type         INT,
  @caliper_type         INT,
  @calipers_orientation NCHAR (50),
  @caliper_text         NVARCHAR(200),
  @caliper_start_ms     BIGINT,
  @caliper_end_ms       BIGINT,
  @caliper_top          INT,
  @caliper_bottom       INT
AS
  BEGIN
    INSERT INTO int_savedevent_calipers
                (patient_id,
                 event_id,
                 channel_type,
                 caliper_type,
                 calipers_orientation,
                 caliper_text,
                 caliper_start_ms,
                 caliper_end_ms,
                 caliper_top,
                 caliper_bottom)
    VALUES      ( @patient_id,
                  @event_id,
                  @channel_type,
                  @caliper_type,
                  @calipers_orientation,
                  @caliper_text,
                  @caliper_start_ms,
                  @caliper_end_ms,
                  @caliper_top,
                  @caliper_bottom)
  END


