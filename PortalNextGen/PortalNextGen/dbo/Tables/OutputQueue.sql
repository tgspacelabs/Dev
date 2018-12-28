CREATE TABLE [dbo].[OutputQueue] (
    [OutputQueueID]   INT            IDENTITY (1, 1) NOT NULL,
    [MessageStatus]   CHAR (1)       NOT NULL,
    [MessageNumber]   VARCHAR (20)   NOT NULL,
    [LongText]        NVARCHAR (MAX) NOT NULL,
    [ShortText]       NVARCHAR (255) NOT NULL,
    [PatientID]       INT            NOT NULL,
    [MshSystem]       NVARCHAR (50)  NOT NULL,
    [MshOrganization] NVARCHAR (50)  NOT NULL,
    [MshEventCode]    NVARCHAR (10)  NOT NULL,
    [MshMessageType]  NVARCHAR (10)  NOT NULL,
    [SentDateTime]    DATETIME2 (7)  NOT NULL,
    [QueuedDateTime]  DATETIME2 (7)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_OutputQueue_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_OutputQueue_OutputQueueID] PRIMARY KEY CLUSTERED ([OutputQueueID] ASC),
    CONSTRAINT [CK_OutputQueue_MessageStatus] CHECK ([MessageStatus]='R' OR [MessageStatus]='P' OR [MessageStatus]='N' OR [MessageStatus]='E'),
    CONSTRAINT [FK_OutputQueue_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OutputQueue_MessageNumber]
    ON [dbo].[OutputQueue]([MessageNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_OutputQueue_QueuedDateTime]
    ON [dbo].[OutputQueue]([QueuedDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_OutputQueue_SentDateTime]
    ON [dbo].[OutputQueue]([SentDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OutputQueue_Patient_PatientID]
    ON [dbo].[OutputQueue]([PatientID] ASC);

