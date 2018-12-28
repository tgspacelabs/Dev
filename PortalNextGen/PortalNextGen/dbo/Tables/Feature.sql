CREATE TABLE [dbo].[Feature] (
    [FeatureID]       INT           IDENTITY (1, 1) NOT NULL,
    [FeatureCode]     VARCHAR (25)  NOT NULL,
    [Description]     VARCHAR (120) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Feature_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Feature_FeatureID] PRIMARY KEY CLUSTERED ([FeatureID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Feature_FeatureCode]
    ON [dbo].[Feature]([FeatureCode] ASC);

