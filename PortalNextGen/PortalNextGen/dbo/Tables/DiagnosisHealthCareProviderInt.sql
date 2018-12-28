CREATE TABLE [dbo].[DiagnosisHealthCareProviderInt] (
    [DiagnosisHealthCareProviderInt] BIGINT        IDENTITY (0, 1) NOT NULL,
    [EncounterID]                    INT           NOT NULL,
    [DiagnosisTypeCodeID]            INT           NOT NULL,
    [DiagnosisSequenceNumber]        INT           NOT NULL,
    [InactiveSwitch]                 BIT           NOT NULL,
    [DiagnosisDateTime]              DATETIME2 (7) NULL,
    [DescriptionKey]                 INT           NOT NULL,
    [HealthCareProviderID]           INT           NULL,
    [CreatedDateTime]                DATETIME2 (7) CONSTRAINT [DF_DiagnosisHealthCareProviderInt_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DiagnosisHealthCareProviderInt_DiagnosisHealthCareProviderIntID] PRIMARY KEY CLUSTERED ([DiagnosisHealthCareProviderInt] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DiagnosisHealthCareProviderInt_EncounterID_DiagnosisTypeCodeID_DiagnosisSequenceNumber_InactiveSwitch]
    ON [dbo].[DiagnosisHealthCareProviderInt]([EncounterID] ASC, [DiagnosisTypeCodeID] ASC, [DiagnosisSequenceNumber] ASC, [InactiveSwitch] ASC);

