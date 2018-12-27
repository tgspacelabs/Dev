﻿CREATE PROCEDURE [dbo].[uspWritePacerSpikeLog]
    (
     @UserID UNIQUEIDENTIFIER,
     @PatientId UNIQUEIDENTIFIER,
     @SampleRate SMALLINT,
     @StartFt BIGINT,
     @NumSpikes INT,
     @SpikeData IMAGE
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[PacerSpikeLog]
            ([user_id],
             [patient_id],
             [sample_rate],
             [start_ft],
             [num_spikes],
             [spike_data]
            )
    VALUES
            (@UserID,
             @PatientId,
             @SampleRate,
             @StartFt,
             @NumSpikes,
             @SpikeData
            );
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'uspWritePacerSpikeLog';