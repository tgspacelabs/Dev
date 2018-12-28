CREATE TABLE [dbo].[MessageAcknowledgement] (
    [MessageAcknowledgementID]        INT           IDENTITY (1, 1) NOT NULL,
    [MessageControlID]                NVARCHAR (20) NOT NULL,
    [MessageStatus]                   CHAR (1)      NOT NULL,
    [ClientIP]                        NVARCHAR (30) NOT NULL,
    [AcknowledgementMessageControlID] NVARCHAR (20) NULL,
    [AcknowledgementSystem]           NVARCHAR (50) NULL,
    [AcknowledgementOrganization]     NVARCHAR (50) NULL,
    [ReceivedDateTime]                DATETIME2 (7) NULL,
    [Notes]                           NVARCHAR (80) NULL,
    [NumberOfRetries]                 INT           NULL,
    [CreatedDateTime]                 DATETIME2 (7) CONSTRAINT [DF_MessageAcknowledgement_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MessageAcknowledgement_MessageAcknowledgementID] PRIMARY KEY CLUSTERED ([MessageAcknowledgementID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MessageAcknowledgement_MessageControlID_ClientIP]
    ON [dbo].[MessageAcknowledgement]([MessageControlID] ASC, [ClientIP] ASC);

