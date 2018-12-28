CREATE TABLE [dbo].[MasterPatientIndexDecisionLog] (
    [MasterPatientIndexDecisionLogID] INT           IDENTITY (1, 1) NOT NULL,
    [CandidateID]                     INT           NOT NULL,
    [MatchedID]                       INT           NOT NULL,
    [Score]                           INT           NOT NULL,
    [ModifiedDateTime]                DATETIME2 (7) NOT NULL,
    [StatusCode]                      VARCHAR (3)   NULL,
    [CreatedDateTime]                 DATETIME2 (7) CONSTRAINT [DF_MasterPatientIndexDecisionLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexDecisionLog_MasterPatientIndexDecisionLogID] PRIMARY KEY CLUSTERED ([MasterPatientIndexDecisionLogID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MasterPatientIndexDecisionLog_CandidateID_MatchedID]
    ON [dbo].[MasterPatientIndexDecisionLog]([CandidateID] ASC, [MatchedID] ASC);

