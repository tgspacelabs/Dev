CREATE TABLE [dbo].[EncounterTransferHistory] (
    [EncounterTransferHistoryID]  INT           IDENTITY (1, 1) NOT NULL,
    [EncounterXID]                NVARCHAR (30) NOT NULL,
    [OrganizationID]              INT           NOT NULL,
    [EncounterID]                 INT           NOT NULL,
    [PatientID]                   INT           NOT NULL,
    [OriginalPatientID]           INT           NULL,
    [TransferTransactionDateTime] DATETIME2 (7) NULL,
    [TransferredFromEncounterID]  INT           NULL,
    [TransferredToEncounterID]    INT           NULL,
    [TransferredFromPatientID]    INT           NULL,
    [TransferredToPatientID]      INT           NULL,
    [StatusCode]                  NCHAR (1)     NULL,
    [EventCode]                   NVARCHAR (4)  NULL,
    [CreatedDateTime]             DATETIME2 (7) CONSTRAINT [DF_EncounterTransferHistory_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EncounterTransferHistory_EncounterTransferHistoryID] PRIMARY KEY CLUSTERED ([EncounterTransferHistoryID] ASC),
    CONSTRAINT [FK_EncounterTransferHistory_Encounter_EncounterID] FOREIGN KEY ([EncounterID]) REFERENCES [dbo].[Encounter] ([EncounterID]),
    CONSTRAINT [FK_EncounterTransferHistory_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID]),
    CONSTRAINT [FK_EncounterTransferHistory_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_EncounterTransferHistory_EncounterXID_OrganizationID]
    ON [dbo].[EncounterTransferHistory]([EncounterXID] ASC, [OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterTransferHistory_Encounter_EncounterID]
    ON [dbo].[EncounterTransferHistory]([EncounterID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterTransferHistory_Organization_OrganizationID]
    ON [dbo].[EncounterTransferHistory]([OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterTransferHistory_Patient_PatientID]
    ON [dbo].[EncounterTransferHistory]([PatientID] ASC);

