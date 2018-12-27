﻿CREATE PROCEDURE [dbo].[uspWriteEventData]
    (
    @UserID UNIQUEIDENTIFIER,
    @PatientId UNIQUEIDENTIFIER,
    @Type INT,
    @NumEvents INT,
    @EventData IMAGE,
    @SampleRate SMALLINT)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[AnalysisEvents] ([user_id],
                                        [patient_id],
                                        [type],
                                        [num_events],
                                        [sample_rate],
                                        [event_data])
    VALUES (
           @UserID, @PatientId, @Type, @NumEvents, @SampleRate, @EventData
           );
END;
GO
EXECUTE [sys].[sp_addextendedproperty]
    @name = N'MS_Description',
    @value = N'',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'PROCEDURE',
    @level1name = N'uspWriteEventData';
