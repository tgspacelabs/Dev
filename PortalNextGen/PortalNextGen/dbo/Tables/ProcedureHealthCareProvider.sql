CREATE TABLE [dbo].[ProcedureHealthCareProvider] (
    [ProcedureHealthCareProviderID]    INT           IDENTITY (1, 1) NOT NULL,
    [EncounterID]                      INT           NOT NULL,
    [procedureCodeID]                  INT           NOT NULL,
    [SequenceNumber]                   INT           NOT NULL,
    [DescriptionKey]                   INT           NOT NULL,
    [HealthCareProviderID]             INT           NOT NULL,
    [procHealthCareProvidertypeCodeID] INT           NOT NULL,
    [CreatedDateTime]                  DATETIME2 (7) CONSTRAINT [DF_ProcedureHealthCareProvider_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ProcedureHealthCareProvider_ProcedureHealthCareProviderID] PRIMARY KEY CLUSTERED ([ProcedureHealthCareProviderID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProcedureHealthCareProvider_EncounterID_ProcedureCodeID_SequenceNumber_DescriptionKey]
    ON [dbo].[ProcedureHealthCareProvider]([EncounterID] ASC, [procedureCodeID] ASC, [SequenceNumber] ASC, [DescriptionKey] ASC);

