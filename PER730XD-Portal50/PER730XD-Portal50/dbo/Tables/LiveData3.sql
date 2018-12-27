CREATE TABLE [dbo].[LiveData3] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [Mod4]            INT              NOT NULL,
    CONSTRAINT [PK_LiveData3_Id_Mod4] PRIMARY KEY NONCLUSTERED ([Id] ASC, [Mod4] ASC),
    CONSTRAINT [CK_Mod4_2] CHECK ([Mod4]=(2))
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_LiveData3_TimeStampUTC_Sequence]
    ON [dbo].[LiveData3]([TimestampUTC] ASC, [Mod4] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData3_Id_Mod4]
    ON [dbo].[LiveData3]([Id] ASC, [Mod4] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData3_TopicInstanceId_TimestampUTC]
    ON [dbo].[LiveData3]([TopicInstanceId] ASC, [TimestampUTC] ASC);

