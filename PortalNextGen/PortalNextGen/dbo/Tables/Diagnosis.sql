CREATE TABLE [dbo].[Diagnosis] (
    [DiagnosisID]           INT            IDENTITY (1, 1) NOT NULL,
    [EncounterID]           INT            NOT NULL,
    [DiagnosisTypeCodeID]   INT            NOT NULL,
    [SequenceNumber]        INT            NOT NULL,
    [DiagnosisCodeID]       INT            NULL,
    [InactiveSwitch]        BIT            NOT NULL,
    [DiagnosisDateTime]     DATETIME2 (7)  NULL,
    [ClassCodeID]           INT            NULL,
    [ConfidentialIndicator] TINYINT        NULL,
    [AttestationDateTime]   DATETIME2 (7)  NULL,
    [Description]           NVARCHAR (255) NULL,
    [CreatedDateTime]       DATETIME2 (7)  CONSTRAINT [DF_Diagnosis_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Diagnosis_DiagnosisID] PRIMARY KEY CLUSTERED ([DiagnosisID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Diagnosis_EncounterID]
    ON [dbo].[Diagnosis]([EncounterID] ASC);

