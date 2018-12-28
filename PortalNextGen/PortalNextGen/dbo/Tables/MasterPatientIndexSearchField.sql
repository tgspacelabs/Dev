CREATE TABLE [dbo].[MasterPatientIndexSearchField] (
    [MasterPatientIndexSearchFieldID] INT            IDENTITY (1, 1) NOT NULL,
    [FieldName]                       NVARCHAR (30)  NOT NULL,
    [ColumnName]                      NVARCHAR (30)  NULL,
    [Low]                             SMALLINT       NOT NULL,
    [High]                            SMALLINT       NOT NULL,
    [CompareType]                     NVARCHAR (30)  NULL,
    [CodeCategory]                    NVARCHAR (4)   NULL,
    [IsSecondary]                     INT            NULL,
    [IsPrimary]                       INT            NULL,
    [HL7Field]                        NVARCHAR (100) NULL,
    [CreatedDateTime]                 DATETIME2 (7)  CONSTRAINT [DF_MasterPatientIndexSearchField_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexSearchField_MasterPatientIndexSearchFieldID] PRIMARY KEY CLUSTERED ([MasterPatientIndexSearchFieldID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MasterPatientIndexSearchField_FieldName]
    ON [dbo].[MasterPatientIndexSearchField]([FieldName] ASC);

