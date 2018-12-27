CREATE TABLE [dbo].[LiveData1] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [Mod4]            INT              NOT NULL,
    CONSTRAINT [PK_LiveData1_Id_Mod4] PRIMARY KEY NONCLUSTERED ([Id] ASC, [Mod4] ASC),
    CONSTRAINT [CK_Mod4_0] CHECK ([Mod4]=(0))
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_LiveData1_TimeStampUTC_Sequence]
    ON [dbo].[LiveData1]([TimestampUTC] ASC, [Mod4] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData1_Id_Mod4]
    ON [dbo].[LiveData1]([Id] ASC, [Mod4] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData1_TopicInstanceId_TimestampUTC]
    ON [dbo].[LiveData1]([TopicInstanceId] ASC, [TimestampUTC] ASC);

