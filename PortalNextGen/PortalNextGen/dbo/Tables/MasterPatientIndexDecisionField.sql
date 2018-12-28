CREATE TABLE [dbo].[MasterPatientIndexDecisionField] (
    [MasterPatientIndexDecisionFieldID] INT           IDENTITY (1, 1) NOT NULL,
    [CandidateID]                       INT           NOT NULL,
    [MatchedID]                         INT           NOT NULL,
    [FieldID]                           INT           NOT NULL,
    [Score]                             TINYINT       NOT NULL,
    [CreatedDateTime]                   DATETIME2 (7) CONSTRAINT [DF_MasterPatientIndexDecisionField_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexDecisionField_MasterPatientIndexDecisionFieldID] PRIMARY KEY CLUSTERED ([MasterPatientIndexDecisionFieldID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MasterPatientIndexDecisionField_CandidateID_MatchedID_FieldID]
    ON [dbo].[MasterPatientIndexDecisionField]([CandidateID] ASC, [MatchedID] ASC, [FieldID] ASC);

