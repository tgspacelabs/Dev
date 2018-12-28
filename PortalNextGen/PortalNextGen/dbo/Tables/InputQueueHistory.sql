CREATE TABLE [dbo].[InputQueueHistory] (
    [InputQueueHistoryID]      INT            IDENTITY (1, 1) NOT NULL,
    [MessageNumber]            NUMERIC (10)   NOT NULL,
    [RecordID]                 INT            NOT NULL,
    [MessageStatus]            CHAR (1)       NOT NULL,
    [QueuedDateTime]           DATETIME2 (7)  NOT NULL,
    [OutboundAnalyzedDateTime] DATETIME2 (7)  NULL,
    [HL7TextShort]             NVARCHAR (255) NULL,
    [HL7TextLong]              NVARCHAR (MAX) NULL,
    [ProcessedDateTime]        DATETIME2 (7)  NULL,
    [ProcessedDuration]        INT            NULL,
    [ThreadID]                 INT            NULL,
    [Who]                      NVARCHAR (20)  NULL,
    [CreatedDateTime]          DATETIME2 (7)  CONSTRAINT [DF_InputQueueHistory_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_InputQueueHistory_InputQueueHistoryID] PRIMARY KEY CLUSTERED ([InputQueueHistoryID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_InputQueueHistory_MessageNumber_RecordID]
    ON [dbo].[InputQueueHistory]([MessageNumber] ASC, [RecordID] ASC);

