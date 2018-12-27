﻿
CREATE PROCEDURE [dbo].[GetSavedEventWaveFormType]
  (
  @patient_id UNIQUEIDENTIFIER,
  @event_id   UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT waveform_category AS WAVEFORM_TYPE
    FROM   [dbo].[int_savedevent_waveform]
    WHERE  patient_id = @patient_id AND event_id = @event_id AND visible = 1
    ORDER  BY waveform_category ASC
  END
