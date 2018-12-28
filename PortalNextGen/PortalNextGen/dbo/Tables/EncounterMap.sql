CREATE TABLE [dbo].[EncounterMap] (
    [EncounterMapID]    INT           IDENTITY (1, 1) NOT NULL,
    [EncounterXID]      NVARCHAR (40) NOT NULL,
    [OrganizationID]    INT           NOT NULL,
    [EncounterID]       INT           NOT NULL,
    [PatientID]         INT           NOT NULL,
    [SequenceNumber]    INT           NOT NULL,
    [OriginalPatientID] INT           NULL,
    [StatusCode]        NVARCHAR (3)  NOT NULL,
    [EventCode]         NVARCHAR (4)  NOT NULL,
    [AccountID]         INT           NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_EncounterMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EncounterMap_EncounterMapID] PRIMARY KEY CLUSTERED ([EncounterMapID] ASC),
    CONSTRAINT [FK_EncounterMap_Account_AccountID] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Account] ([AccountID]),
    CONSTRAINT [FK_EncounterMap_Encounter_EncounterID] FOREIGN KEY ([EncounterID]) REFERENCES [dbo].[Encounter] ([EncounterID]),
    CONSTRAINT [FK_EncounterMap_Organization] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID]),
    CONSTRAINT [FK_EncounterMap_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_EncounterMap_EncounterXID_OrganizationID_PatientID_StatusCode_AccountID_SequenceNumber]
    ON [dbo].[EncounterMap]([EncounterXID] ASC, [OrganizationID] ASC, [PatientID] ASC, [StatusCode] ASC, [AccountID] ASC, [SequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_EncounterMap_EncounterID]
    ON [dbo].[EncounterMap]([EncounterID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_EncounterMap_PatientID]
    ON [dbo].[EncounterMap]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterMap_Encounter_EncounterID]
    ON [dbo].[EncounterMap]([EncounterID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterMap_Organization]
    ON [dbo].[EncounterMap]([OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterMap_Patient_PatientID]
    ON [dbo].[EncounterMap]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterMap_Account_AccountID]
    ON [dbo].[EncounterMap]([AccountID] ASC);

