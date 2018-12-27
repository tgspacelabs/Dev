CREATE TABLE [dbo].[WaveformLiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [SampleCount]     INT              NOT NULL,
    [TypeName]        VARCHAR (50)     NULL,
    [TypeId]          BIGINT NULL,
    [Samples]         VARBINARY (MAX)  NOT NULL,
    [TopicInstanceId] BIGINT NOT NULL,
    [StartTimeUTC]    DATETIME         NOT NULL,
    [EndTimeUTC]      DATETIME         NOT NULL,
    [Id]              BIGINT NOT NULL,
    CONSTRAINT [PK_WaveformLiveData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_WaveformLiveData_AlarmsStatusData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[AlarmsStatusData] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_DeviceInfoData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[DeviceInfoData] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_DeviceSessions_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[DeviceSessions] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_int_print_job_et_vitals_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[int_print_job_et_vitals] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_int_print_job_et_waveform_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[int_print_job_et_waveform] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_MetaData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[MetaData] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_PatientData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[PatientData] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_PatientSessions_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[PatientSessions] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_StatusData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[StatusData] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_StatusDataSets_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[StatusDataSets] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_TopicSessions_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[TopicSessions] ([Id]),
    CONSTRAINT [FK_WaveformLiveData_TopicTypes_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[TopicTypes] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TypeId_StartTimeUTC_EndTimeUTC_Samples_TopicInstanceId]
    ON [dbo].[WaveformLiveData]([TypeId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] ASC)
    INCLUDE([Samples], [TopicInstanceId]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TopicInstanceId_TypeId_EndTimeUTC_StartTimeUTC_Id]
    ON [dbo].[WaveformLiveData]([TopicInstanceId] ASC, [TypeId] ASC, [EndTimeUTC] ASC)
    INCLUDE([StartTimeUTC], [Id]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This is the waveform live feed data for a patient topic session.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WaveformLiveData';

