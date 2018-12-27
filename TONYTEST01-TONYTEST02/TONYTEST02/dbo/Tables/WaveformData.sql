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
    CONSTRAINT [PK_WaveformData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [idxc_WaveformData_1]
    ON [dbo].[WaveformData]([TopicSessionId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] ASC, [TypeId] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_Waveformdata1]
    ON [dbo].[WaveformData]([TopicSessionId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] DESC);

