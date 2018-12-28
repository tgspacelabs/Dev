CREATE TABLE [dbo].[MasterPatientIndexDecisionQueue] (
    [MasterPatientIndexDecisionQueueID] INT           IDENTITY (1, 1) NOT NULL,
    [CandidateID]                       INT           NOT NULL,
    [ModifiedDateTime]                  DATETIME2 (7) NOT NULL,
    [ProcessedDateTime]                 DATETIME2 (7) NULL,
    [CreatedDateTime]                   DATETIME2 (7) CONSTRAINT [DF_MasterPatientIndexDecisionQueue_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexDecisionQueue_MasterPatientIndexDecisionQueueID] PRIMARY KEY CLUSTERED ([MasterPatientIndexDecisionQueueID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MasterPatientIndexDecisionQueue_CandidateID_ProcessedDateTime]
    ON [dbo].[MasterPatientIndexDecisionQueue]([CandidateID] ASC, [ProcessedDateTime] ASC);

