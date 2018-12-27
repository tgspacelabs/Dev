CREATE TABLE [dbo].[EventsDataX] (
    [TimeStampUTC]   DATETIME         CONSTRAINT [DF_EventsDataX_TimeStampUTC] DEFAULT (sysutcdatetime()) NOT NULL,
    [Id]             UNIQUEIDENTIFIER CONSTRAINT [DF_EventsDataX_Id] DEFAULT (newid()) NOT NULL,
    [CategoryValue]  INT              CONSTRAINT [DF_EventsDataX_CategoryValue] DEFAULT ((0)) NOT NULL,
    [Type]           INT              CONSTRAINT [DF_EventsDataX_Type] DEFAULT ((0)) NOT NULL,
    [Subtype]        INT              CONSTRAINT [DF_EventsDataX_Subtype] DEFAULT ((0)) NOT NULL,
    [Value1]         REAL             CONSTRAINT [DF_EventsDataX_Value1] DEFAULT ((0.0)) NOT NULL,
    [Value2]         REAL             CONSTRAINT [DF_EventsDataX_Value2] DEFAULT ((0.0)) NOT NULL,
    [Status]         INT              CONSTRAINT [DF_EventsDataX_Status] DEFAULT ((0)) NOT NULL,
    [ValidLeads]     INT              CONSTRAINT [DF_EventsDataX_ValidLeads] DEFAULT ((0)) NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER CONSTRAINT [DF_EventsDataX_TopicSessionId] DEFAULT (newid()) NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER CONSTRAINT [DF_EventsDataX_FeedTypeId] DEFAULT (newid()) NOT NULL,
    [Sequence]       BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_EventsDataX_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);

