CREATE TABLE [dbo].[MasterPatientIndexPatientLink] (
    [MasterPatientIndexPatientLinkID] INT           IDENTITY (1, 1) NOT NULL,
    [OriginalPatientID]               INT           NOT NULL,
    [NewPatientID]                    INT           NOT NULL,
    [UserID]                          INT           NULL,
    [ModifiedDateTime]                DATETIME2 (7) NOT NULL,
    [CreatedDateTime]                 DATETIME2 (7) CONSTRAINT [DF_MasterPatientIndexPatientLink_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexPatientLink_MasterPatientIndexPatientLinkID] PRIMARY KEY CLUSTERED ([MasterPatientIndexPatientLinkID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MasterPatientIndexPatientLink_OriginalPatientID_NewPatientID]
    ON [dbo].[MasterPatientIndexPatientLink]([OriginalPatientID] ASC, [NewPatientID] ASC);

