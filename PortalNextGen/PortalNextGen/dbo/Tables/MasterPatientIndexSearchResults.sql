CREATE TABLE [dbo].[MasterPatientIndexSearchResults] (
    [MasterPatientIndexSearchResultsID] INT           IDENTITY (1, 1) NOT NULL,
    [Spid]                              INT           NULL,
    [PersonID]                          INT           NULL,
    [CreatedDateTime]                   DATETIME2 (7) CONSTRAINT [DF_MasterPatientIndexSearchResults_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexSearchResults_MasterPatientIndexSearchResultsID] PRIMARY KEY CLUSTERED ([MasterPatientIndexSearchResultsID] ASC)
);

