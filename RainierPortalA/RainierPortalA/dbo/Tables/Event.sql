CREATE TABLE [dbo].[Event] (
    [EventID]         INT           NOT NULL,
    [Timestamp]       ROWVERSION    NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Event_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Event_EventID] PRIMARY KEY CLUSTERED ([EventID] ASC)
);

