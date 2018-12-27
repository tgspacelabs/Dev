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
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TopicInstanceId_StartTimeUTC]
    ON [dbo].[WaveformLiveData]([TopicInstanceId] ASC, [StartTimeUTC] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TopicInstanceId_Sequence_TypeId_Samples_StartTimeUTC_EndTimeUTC]
    ON [dbo].[WaveformLiveData]([TopicInstanceId] ASC)
    INCLUDE([Sequence], [TypeId], [Samples], [StartTimeUTC], [EndTimeUTC]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TypeId_TopicInstanceId_Sequence_Samples_StartTimeUTC_EndTimeUTC]
    ON [dbo].[WaveformLiveData]([TypeId] ASC, [TopicInstanceId] ASC)
    INCLUDE([Sequence], [Samples], [StartTimeUTC], [EndTimeUTC]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_Id_Sequence]
    ON [dbo].[WaveformLiveData]([Id] ASC)
    INCLUDE([Sequence]) WITH (FILLFACTOR = 100);

