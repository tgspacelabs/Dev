CREATE TABLE [dbo].[EncounterToDiagnosisHealthCareProviderInt] (
    [EncounterToDiagnosisHealthCareProviderInt] BIGINT        IDENTITY (0, 1) NOT NULL,
    [EncounterID]                               INT           NOT NULL,
    [HealthCareProviderID]                      INT           NOT NULL,
    [HealthCareProviderRoleCode]                NCHAR (1)     NOT NULL,
    [EndDateTime]                               DATETIME2 (7) NULL,
    [ActiveSwitch]                              BIT           NOT NULL,
    [CreatedDateTime]                           DATETIME2 (7) CONSTRAINT [DF_EncounterToDiagnosisHealthCareProviderInt_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EncounterToDiagnosisHealthCareProviderInt_EncounterToDiagnosisHealthCareProviderIntID] PRIMARY KEY CLUSTERED ([EncounterToDiagnosisHealthCareProviderInt] ASC),
    CONSTRAINT [FK_EncounterToDiagnosisHealthCareProviderInt_Encounter_EncounterID] FOREIGN KEY ([EncounterID]) REFERENCES [dbo].[Encounter] ([EncounterID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_EncounterToDiagnosisHealthCareProviderInt_EncounterID_HealthCareProviderID_HealthCareProviderRoleCode]
    ON [dbo].[EncounterToDiagnosisHealthCareProviderInt]([EncounterID] ASC, [HealthCareProviderID] ASC, [HealthCareProviderRoleCode] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EncounterToDiagnosisHealthCareProviderInt_Encounter_EncounterID]
    ON [dbo].[EncounterToDiagnosisHealthCareProviderInt]([EncounterID] ASC);

