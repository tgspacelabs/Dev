CREATE TABLE [dbo].[DiagnosisRelatedGroup] (
    [DiagnosisRelatedGroupID]                          INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]                                        INT           NOT NULL,
    [EncounterID]                                      INT           NOT NULL,
    [AccountID]                                        INT           NOT NULL,
    [DescriptionKey]                                   INT           NOT NULL,
    [OriginalPatientID]                                INT           NULL,
    [DiagnosisRelatedGroupCodeID]                      INT           NULL,
    [DiagnosisRelatedGroupAssignmentDateTime]          DATETIME2 (7) NULL,
    [DiagnosisRelatedGroupApprovalIndicator]           NCHAR (2)     NULL,
    [DiagnosisRelatedGroupGrperReviewCodeID]           INT           NULL,
    [DiagnosisRelatedGroupOutlierCodeID]               INT           NULL,
    [DiagnosisRelatedGroupOutlierDaysNumber]           INT           NULL,
    [DiagnosisRelatedGroupOutlierCostAmount]           SMALLMONEY    NULL,
    [DiagnosisRelatedGroupGrperVerificationTypeCodeID] INT           NULL,
    [CreatedDateTime]                                  DATETIME2 (7) CONSTRAINT [DF_DiagnosisRelatedGroup_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DiagnosisRelatedGroup_DiagnosisRelatedGroupID] PRIMARY KEY CLUSTERED ([DiagnosisRelatedGroupID] ASC),
    CONSTRAINT [FK_DiagnosisRelatedGroup_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DiagnosisRelatedGroup_DescriptionKey]
    ON [dbo].[DiagnosisRelatedGroup]([DescriptionKey] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DiagnosisRelatedGroup_PatientID_EncounterID_AccountID_DescriptionKey]
    ON [dbo].[DiagnosisRelatedGroup]([PatientID] ASC, [EncounterID] ASC, [AccountID] ASC, [DescriptionKey] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DiagnosisRelatedGroup_Patient_PatientID]
    ON [dbo].[DiagnosisRelatedGroup]([PatientID] ASC);

