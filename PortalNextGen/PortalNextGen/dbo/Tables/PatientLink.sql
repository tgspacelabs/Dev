CREATE TABLE [dbo].[PatientLink] (
    [PatientLinkID]              INT           IDENTITY (1, 1) NOT NULL,
    [MessageNumber]              INT           NOT NULL,
    [PatientMedicalRecordNumber] NVARCHAR (20) NOT NULL,
    [PatientVisitNumber]         NVARCHAR (20) NOT NULL,
    [PatientID]                  INT           NULL,
    [CreatedDateTime]            DATETIME2 (7) CONSTRAINT [DF_PatientLink_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientLink_PatientLinkID] PRIMARY KEY CLUSTERED ([PatientLinkID] ASC),
    CONSTRAINT [FK_PatientLink_InboundMessage_MessageNumber] FOREIGN KEY ([MessageNumber]) REFERENCES [dbo].[InboundMessage] ([MessageNumber]),
    CONSTRAINT [FK_PatientLink_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientLink_MessageNumber]
    ON [dbo].[PatientLink]([MessageNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_HL7PatientLink_MessageNumber]
    ON [dbo].[PatientLink]([MessageNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientLink_InboundMessage_MessageNumber]
    ON [dbo].[PatientLink]([MessageNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientLink_Patient_PatientID]
    ON [dbo].[PatientLink]([PatientID] ASC);

