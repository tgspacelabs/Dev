CREATE TABLE [dbo].[Encounter] (
    [EncounterID]     INT           NOT NULL,
    [PatientID]       INT           NOT NULL,
    [BeginDateTime]   DATETIME2 (7) NOT NULL,
    [EndDateTime]     DATETIME2 (7) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Encounter_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Encounter_EncounterID] PRIMARY KEY CLUSTERED ([EncounterID] ASC),
    CONSTRAINT [FK_Encounter_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Encounter_Patient_PatientID]
    ON [dbo].[Encounter]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Encounter_PatientID]
    ON [dbo].[Encounter]([PatientID] ASC);

