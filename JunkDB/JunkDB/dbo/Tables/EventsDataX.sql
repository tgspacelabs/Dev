CREATE TABLE [dbo].[EventsDataX]
    (
     [TimeStampUTC] DATETIME NOT NULL CONSTRAINT [DF_EventsDataX_TimeStampUTC] DEFAULT (SYSUTCDATETIME()),
     [Id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF_EventsDataX_Id] DEFAULT (NEWID()),
     [CategoryValue] INT NOT NULL CONSTRAINT [DF_EventsDataX_CategoryValue] DEFAULT (0),
     [Type] INT NOT NULL CONSTRAINT [DF_EventsDataX_Type] DEFAULT (0),
     [Subtype] INT NOT NULL CONSTRAINT [DF_EventsDataX_Subtype] DEFAULT (0),
     [Value1] REAL NOT NULL CONSTRAINT [DF_EventsDataX_Value1] DEFAULT (0.0),
     [Value2] REAL NOT NULL CONSTRAINT [DF_EventsDataX_Value2] DEFAULT (0.0),
     [Status] INT NOT NULL CONSTRAINT [DF_EventsDataX_Status] DEFAULT (0),
     [ValidLeads] INT NOT NULL CONSTRAINT [DF_EventsDataX_ValidLeads] DEFAULT (0),
     [TopicSessionId] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF_EventsDataX_TopicSessionId] DEFAULT (NEWID()),
     [FeedTypeId] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF_EventsDataX_FeedTypeId] DEFAULT (NEWID()),
     [Sequence] BIGINT NOT NULL IDENTITY(1, 1),
     CONSTRAINT [PK_EventsDataX_Sequence] PRIMARY KEY CLUSTERED ([Sequence])
    );
--GO
--ALTER TABLE [dbo].[EventsDataX]
--ADD CONSTRAINT [DF_EventsDataX_TimeStampUTC] DEFAULT (SYSUTCDATETIME()) FOR [TimeStampUTC] 
