CREATE TABLE [dbo].[Vital] (
    [VitalID]         INT           IDENTITY (1, 1) NOT NULL,
    [SetID]           INT           NOT NULL,
    [Name]            VARCHAR (25)  NOT NULL,
    [Value]           VARCHAR (25)  NULL,
    [TopicSessionID]  INT           NOT NULL,
    [FeedTypeID]      INT           NOT NULL,
    [Timestamp]       DATETIME2 (7) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Vital_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Vital_VitalID] PRIMARY KEY CLUSTERED ([VitalID] ASC),
    CONSTRAINT [FK_Vital_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID]),
    CONSTRAINT [FK_Vital_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_VitalsData_Timestamp]
    ON [dbo].[Vital]([Timestamp] ASC, [VitalID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Vital_TopicSessionID_TimestampUTC_Name_FeedTypeID_VitalID_Value]
    ON [dbo].[Vital]([TopicSessionID] ASC, [Timestamp] ASC, [Name] ASC, [FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Vital_Name_FeedTypeID_Value_TopicSessionID_Timestamp]
    ON [dbo].[Vital]([Name] ASC, [FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Vital_FeedType_FeedTypeID]
    ON [dbo].[Vital]([FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Vital_TopicSession_TopicSessionID]
    ON [dbo].[Vital]([TopicSessionID] ASC);

