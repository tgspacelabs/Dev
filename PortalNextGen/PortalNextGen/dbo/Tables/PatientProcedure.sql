CREATE TABLE [dbo].[PatientProcedure] (
    [PatientProcedureID]  INT           IDENTITY (1, 1) NOT NULL,
    [EncounterID]         INT           NOT NULL,
    [ProcedureCodeID]     INT           NOT NULL,
    [SequenceNumber]      SMALLINT      NOT NULL,
    [procDateTime]        DATETIME2 (7) NOT NULL,
    [proc_functionCodeID] INT           NOT NULL,
    [proc_minutes]        SMALLINT      NOT NULL,
    [anesthesiaCodeID]    INT           NULL,
    [anesthesia_minutes]  SMALLINT      NULL,
    [consentCodeID]       INT           NOT NULL,
    [proc_priority]       TINYINT       NULL,
    [assoc_diagCodeID]    INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_PatientProcedure_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientProcedure_PatientProcedureID] PRIMARY KEY CLUSTERED ([PatientProcedureID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientProcedure_EncounterID_ProcedureCodeID]
    ON [dbo].[PatientProcedure]([EncounterID] ASC, [ProcedureCodeID] ASC);

