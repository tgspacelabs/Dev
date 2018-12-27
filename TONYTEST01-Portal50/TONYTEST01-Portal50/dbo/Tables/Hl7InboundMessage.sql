CREATE TABLE [dbo].[Hl7InboundMessage] (
    [MessageNo]                 INT            IDENTITY (1, 1) NOT NULL,
    [MessageStatus]             NCHAR (1)      NOT NULL,
    [Hl7Message]                NVARCHAR (MAX) NOT NULL,
    [Hl7MessageResponse]        NVARCHAR (MAX) NULL,
    [MessageSendingApplication] NVARCHAR (180) NOT NULL,
    [MessageSendingFacility]    NVARCHAR (180) NOT NULL,
    [MessageType]               NCHAR (3)      NOT NULL,
    [MessageTypeEventCode]      NCHAR (3)      NOT NULL,
    [MessageControlId]          NVARCHAR (20)  NOT NULL,
    [MessageVersion]            NVARCHAR (60)  NOT NULL,
    [MessageHeaderDate]         DATETIME       NOT NULL,
    [MessageQueuedDate]         DATETIME       NOT NULL,
    [MessageProcessedDate]      DATETIME       NULL,
    CONSTRAINT [PK_HL7InboundMessage_MessageNo] PRIMARY KEY CLUSTERED ([MessageNo] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Hl7InboundMessage_MessageQueuedDate_ndx1]
    ON [dbo].[Hl7InboundMessage]([MessageQueuedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [Hl7InboundMessage_MessageHeaderDate_ndx2]
    ON [dbo].[Hl7InboundMessage]([MessageHeaderDate] ASC);


GO
CREATE NONCLUSTERED INDEX [Hl7InboundMessage_MessageProcessedDate_ndx3]
    ON [dbo].[Hl7InboundMessage]([MessageProcessedDate] ASC);

