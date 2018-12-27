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
    [Sequence]       BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_WaveformData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformData_TopicSessionId_StartTimeUTC_EndTimeUTC_TypeId]
    ON [dbo].[WaveformData]([TopicSessionId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] ASC, [TypeId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformData_TopicSessionId_StartTimeUTC_EndTimeUTC]
    ON [dbo].[WaveformData]([TopicSessionId] ASC, [StartTimeUTC] ASC, [EndTimeUTC] DESC) WITH (FILLFACTOR = 100);

