CREATE TABLE [dbo].[OutboundQueue] (
    [OutboundQueueID]          INT           IDENTITY (1, 1) NOT NULL,
    [OutboundID]               INT           NOT NULL,
    [MessageEvent]             NVARCHAR (3)  NOT NULL,
    [QueuedDateTime]           DATETIME2 (7) NOT NULL,
    [MessageStatus]            CHAR (1)      NOT NULL,
    [ProcessedDateTime]        DATETIME2 (7) NULL,
    [PatientID]                INT           NOT NULL,
    [OrderID]                  INT           NULL,
    [ObservationStartDateTime] DATETIME2 (7) NULL,
    [ObservationEndDateTime]   DATETIME2 (7) NULL,
    [CreatedDateTime]          DATETIME2 (7) CONSTRAINT [DF_OutboundQueue_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_OutboundQueue_OutboundQueueID] PRIMARY KEY CLUSTERED ([OutboundQueueID] ASC),
    CONSTRAINT [FK_OutboundQueue_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OutboundQueue_OutboundID]
    ON [dbo].[OutboundQueue]([OutboundID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OutboundQueue_Patient_PatientID]
    ON [dbo].[OutboundQueue]([PatientID] ASC);

