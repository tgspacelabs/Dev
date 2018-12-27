CREATE TABLE [dbo].[WaveformLiveData2] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [SampleCount]     INT              NOT NULL,
    [TypeName]        VARCHAR (50)     NULL,
    [TypeId]          UNIQUEIDENTIFIER NULL,
    [Samples]         VARBINARY (MAX)  NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [StartTimeUTC]    DATETIME         NOT NULL,
    [EndTimeUTC]      DATETIME         NOT NULL,
    [Mod4]            INT              NOT NULL,
    CONSTRAINT [PK_WaveformLiveData2_Id_Mod4] PRIMARY KEY NONCLUSTERED ([Id] ASC, [Mod4] ASC),
    CONSTRAINT [CK_WaveformLiveData2_Mod4] CHECK ([Mod4]=(1))
);

