CREATE TABLE [dbo].[InputQueue] (
    [InputQueueID]                 INT            IDENTITY (1, 1) NOT NULL,
    [MessageNumber]                NUMERIC (10)   NOT NULL,
    [MessageStatus]                CHAR (1)       CONSTRAINT [DF_InputQueue_MessageStatus] DEFAULT ('N') NOT NULL,
    [QueuedDateTime]               DATETIME2 (7)  NOT NULL,
    [OutboundAnalyzedDateTime]     DATETIME2 (7)  NULL,
    [MshMessageType]               NCHAR (3)      NOT NULL,
    [MshEventCode]                 NCHAR (3)      NOT NULL,
    [MshOrganization]              NVARCHAR (36)  NOT NULL,
    [MshSystem]                    NVARCHAR (36)  NOT NULL,
    [MshDateTime]                  DATETIME2 (7)  NOT NULL,
    [MshControlID]                 NVARCHAR (36)  NOT NULL,
    [MshAcknowledgementCode]       NCHAR (2)      NULL,
    [MshVersion]                   NVARCHAR (5)   NOT NULL,
    [PatientIDMedicalRecordNumber] NVARCHAR (20)  NULL,
    [pv1_visitNumber]              NVARCHAR (50)  NULL,
    [PatientID]                    INT            NULL,
    [HL7TextShort]                 NVARCHAR (255) NULL,
    [HL7TextLong]                  NVARCHAR (MAX) NULL,
    [ProcessedDateTime]            DATETIME2 (7)  NULL,
    [ProcessedDuration]            INT            NULL,
    [ThreadID]                     INT            NULL,
    [Who]                          NVARCHAR (20)  NULL,
    [CreatedDateTime]              DATETIME2 (7)  CONSTRAINT [DF_InputQueue_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_InputQueue_InputQueueID] PRIMARY KEY CLUSTERED ([InputQueueID] ASC),
    CONSTRAINT [FK_InputQueue_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_InputQueue_MessageNumber]
    ON [dbo].[InputQueue]([MessageNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_InputQueue_Patient_PatientID]
    ON [dbo].[InputQueue]([PatientID] ASC);

