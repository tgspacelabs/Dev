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
    [Mod4]            INT              CONSTRAINT [DF_WaveformLiveData_Mod4] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_WaveformLiveData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_WaveformLiveData_TopicInstanceId_StartTimeUTC_Id]
    ON [dbo].[WaveformLiveData]([TopicInstanceId] ASC, [StartTimeUTC] ASC)
    INCLUDE([Id]) WITH (FILLFACTOR = 100);

