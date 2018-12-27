CREATE TABLE [dbo].[LiveData2] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [Mod4]            INT              NOT NULL,
    CONSTRAINT [PK_LiveData2_Id_Mod4] PRIMARY KEY NONCLUSTERED ([Id] ASC, [Mod4] ASC),
    CONSTRAINT [CK_Mod4_1] CHECK ([Mod4]=(1))
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_LiveData2_TimeStampUTC_Sequence]
    ON [dbo].[LiveData2]([TimestampUTC] ASC, [Mod4] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData2_Id_Mod4]
    ON [dbo].[LiveData2]([Id] ASC, [Mod4] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData2_TopicInstanceId_TimestampUTC]
    ON [dbo].[LiveData2]([TopicInstanceId] ASC, [TimestampUTC] ASC);

