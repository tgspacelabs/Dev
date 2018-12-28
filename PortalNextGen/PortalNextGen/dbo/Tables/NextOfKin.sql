CREATE TABLE [dbo].[NextOfKin] (
    [NextOfKinID]          INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]            INT           NOT NULL,
    [SequenceNumber]       INT           NOT NULL,
    [NotifySequenceNumber] INT           NOT NULL,
    [ActiveFlag]           TINYINT       NOT NULL,
    [OriginalPatientID]    INT           NULL,
    [NextOfKinPersonID]    INT           NOT NULL,
    [ContactPersonID]      INT           NULL,
    [RelationshipCodeID]   INT           NULL,
    [CreatedDateTime]      DATETIME2 (7) CONSTRAINT [DF_NextOfKin_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_NextOfKin_NextOfKinID] PRIMARY KEY CLUSTERED ([NextOfKinID] ASC),
    CONSTRAINT [FK_NextOfKin_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_NextOfKin_PatientID_SequenceNumber_NotifySequenceNumber_ActiveFlag]
    ON [dbo].[NextOfKin]([PatientID] ASC, [SequenceNumber] ASC, [NotifySequenceNumber] ASC, [ActiveFlag] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_NextOfKin_Patient_PatientID]
    ON [dbo].[NextOfKin]([PatientID] ASC);

