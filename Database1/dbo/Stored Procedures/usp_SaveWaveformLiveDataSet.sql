
CREATE PROCEDURE [dbo].[usp_SaveWaveformLiveDataSet]
    (
     @waveformData [dbo].[WaveformDataType] READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[WaveformLiveData]
            ([Id],
             [SampleCount],
             [TypeName],
             [TypeId],
             [Samples],
             [TopicInstanceId],
             [StartTimeUTC],
             [EndTimeUTC]
            )
    SELECT
        [WF].[Id],
        [WF].[SampleCount],
        [WF].[TypeName],
        [WF].[TypeId],
        [WF].[Samples],
        [ts].[TopicInstanceId],
        [WF].[StartTimeUTC],
        [WF].[EndTimeUTC]
    FROM
        @waveformData AS [WF]
        INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[Id] = [WF].[TopicSessionId];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveWaveformLiveDataSet';

