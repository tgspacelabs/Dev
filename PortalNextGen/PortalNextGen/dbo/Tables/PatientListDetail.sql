CREATE TABLE [dbo].[PatientListDetail] (
    [PatientListDetailID]   INT           IDENTITY (1, 1) NOT NULL,
    [PatientListID]         INT           NOT NULL,
    [PatientID]             INT           NOT NULL,
    [OriginalPatientID]     INT           NULL,
    [EncounterID]           INT           NOT NULL,
    [Deleted]               TINYINT       NOT NULL,
    [NewResults]            CHAR (1)      NULL,
    [ViewedResultsDateTime] DATETIME2 (7) NULL,
    [CreatedDateTime]       DATETIME2 (7) CONSTRAINT [DF_PatientListDetail_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientListDetail_PatientListDetailID] PRIMARY KEY CLUSTERED ([PatientListDetailID] ASC),
    CONSTRAINT [FK_PatientListDetail_Patient_PatientID] FOREIGN KEY ([OriginalPatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientListDetail_OriginalPatientID]
    ON [dbo].[PatientListDetail]([OriginalPatientID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientListDetail_PatientListID_PatientID_EncounterID]
    ON [dbo].[PatientListDetail]([PatientListID] ASC, [PatientID] ASC, [EncounterID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientListDetail_Patient_PatientID]
    ON [dbo].[PatientListDetail]([OriginalPatientID] ASC);

