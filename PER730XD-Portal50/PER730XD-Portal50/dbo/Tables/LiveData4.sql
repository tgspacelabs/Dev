CREATE TABLE [dbo].[LiveData4] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [Mod4]            INT              NOT NULL,
    CONSTRAINT [PK_LiveData4_Id_Mod4] PRIMARY KEY NONCLUSTERED ([Id] ASC, [Mod4] ASC),
    CONSTRAINT [CK_Mod4_3] CHECK ([Mod4]=(3))
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_LiveData4_TimeStampUTC_Sequence]
    ON [dbo].[LiveData4]([TimestampUTC] ASC, [Mod4] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData4_Id_Mod4]
    ON [dbo].[LiveData4]([Id] ASC, [Mod4] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData4_TopicInstanceId_TimestampUTC]
    ON [dbo].[LiveData4]([TopicInstanceId] ASC, [TimestampUTC] ASC);

