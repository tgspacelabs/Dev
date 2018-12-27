CREATE TABLE [dbo].[WaveformLiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [SampleCount]     INT              NOT NULL,
    [TypeName]        VARCHAR (50)     NULL,
    [TypeId]          UNIQUEIDENTIFIER NULL,
    [Samples]         VARBINARY (MAX)  NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [StartTimeUTC]    DATETIME         NOT NULL,
    [EndTimeUTC]      DATETIME         NOT NULL,
    CONSTRAINT [PK_WaveformLiveData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TopicInstanceId_TypeId_EndTimeUTC_StartTimeUTC_Id]
    ON [dbo].[WaveformLiveData]([TopicInstanceId] ASC, [TypeId] ASC, [EndTimeUTC] ASC)
    INCLUDE([StartTimeUTC], [Id]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This is the waveform live feed data for a patient topic session.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WaveformLiveData';

