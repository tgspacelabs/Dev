CREATE TABLE [dbo].[MedicalRecordNumberMap] (
    [MedicalRecordNumberMapID]          INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]                    INT           NOT NULL,
    [MedicalRecordNumberXID]            NVARCHAR (30) NOT NULL,
    [PatientID]                         INT           NOT NULL,
    [OriginalPatientID]                 INT           NULL,
    [MergeCode]                         CHAR (1)      NOT NULL,
    [PriorPatientID]                    INT           NULL,
    [MedicalRecordNumberXID2]           NVARCHAR (30) NULL,
    [AdmitDischargeTransferAdmitSwitch] BIT           NOT NULL,
    [CreatedDateTime]                   DATETIME2 (7) CONSTRAINT [DF_MedicalRecordNumberMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MedicalRecordNumberMap_MedicalRecordNumberMapID] PRIMARY KEY CLUSTERED ([MedicalRecordNumberMapID] ASC),
    CONSTRAINT [FK_MedicalRecordNumberMap_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID]),
    CONSTRAINT [FK_MedicalRecordNumberMap_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MedicalRecordNumberMap_MedicalRecordNumberxid_organizationID_PatientID_OriginalPatientID]
    ON [dbo].[MedicalRecordNumberMap]([MedicalRecordNumberXID] ASC, [OrganizationID] ASC, [PatientID] ASC, [OriginalPatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MedicalRecordNumberMap_MergeCode]
    ON [dbo].[MedicalRecordNumberMap]([MergeCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MedicalRecordNumberMap_PatientID_MergeCode_MedicalRecordNumberXID2]
    ON [dbo].[MedicalRecordNumberMap]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_MedicalRecordNumberMap_Organization_OrganizationID]
    ON [dbo].[MedicalRecordNumberMap]([OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_MedicalRecordNumberMap_Patient_PatientID]
    ON [dbo].[MedicalRecordNumberMap]([PatientID] ASC);

