CREATE TABLE [dbo].[WaveformData] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [SampleCount]    INT              NOT NULL,
    [TypeName]       VARCHAR (50)     NULL,
    [TypeId]         UNIQUEIDENTIFIER NULL,
    [Samples]        VARBINARY (MAX)  NOT NULL,
    [Compressed]     BIT              NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [StartTimeUTC]   DATETIME         NOT NULL,
    [EndTimeUTC]     DATETIME         NOT NULL,
    CONSTRAINT [PK_WaveformData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_WaveformData_TopicSessionId_StartTimeUTC_EndTimeUTC_TypeId]
    ON [dbo].[WaveformData]([TopicSessionId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] ASC, [TypeId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformData_TopicSessionId_StartTimeUTC_EndTimeUTC]
    ON [dbo].[WaveformData]([TopicSessionId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] DESC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WaveformData';

