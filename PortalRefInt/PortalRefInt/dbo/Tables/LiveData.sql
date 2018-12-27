CREATE TABLE [dbo].[LiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              BIGINT NOT NULL,
    [TopicInstanceId] BIGINT NOT NULL,
    [FeedTypeId]      BIGINT NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_LiveData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_LiveData_AlarmsStatusData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[AlarmsStatusData] ([Id]),
    CONSTRAINT [FK_LiveData_DeviceInfoData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[DeviceInfoData] ([Id]),
    CONSTRAINT [FK_LiveData_DeviceSessions_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[DeviceSessions] ([Id]),
    CONSTRAINT [FK_LiveData_int_print_job_et_vitals_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[int_print_job_et_vitals] ([Id]),
    CONSTRAINT [FK_LiveData_int_print_job_et_waveform_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[int_print_job_et_waveform] ([Id]),
    CONSTRAINT [FK_LiveData_MetaData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[MetaData] ([Id]),
    CONSTRAINT [FK_LiveData_PatientData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[PatientData] ([Id]),
    CONSTRAINT [FK_LiveData_PatientSessions_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[PatientSessions] ([Id]),
    CONSTRAINT [FK_LiveData_StatusData_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[StatusData] ([Id]),
    CONSTRAINT [FK_LiveData_StatusDataSets_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[StatusDataSets] ([Id]),
    CONSTRAINT [FK_LiveData_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId]),
    CONSTRAINT [FK_LiveData_TopicSessions_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[TopicSessions] ([Id]),
    CONSTRAINT [FK_LiveData_TopicTypes_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[TopicTypes] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_FeedTypeId_Name_TopicInstanceId_Value_TimestampUTC]
    ON [dbo].[LiveData]([FeedTypeId] ASC, [Name] ASC)
    INCLUDE([TopicInstanceId], [Value], [TimestampUTC]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_TimestampUTC_FeedTypeId_Name_Value]
    ON [dbo].[LiveData]([TopicInstanceId] ASC, [TimestampUTC] ASC)
    INCLUDE([FeedTypeId], [Name], [Value]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This is the live feed data for a patient topic session.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LiveData';

