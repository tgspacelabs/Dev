CREATE TABLE [dbo].[HealthCareProviderContact] (
    [HealthCareProviderContactID] INT           IDENTITY (1, 1) NOT NULL,
    [HealthCareProviderID]        INT           NOT NULL,
    [ContactTypeCodeID]           INT           NOT NULL,
    [SequenceNumber]              SMALLINT      NOT NULL,
    [ContactNumber]               NVARCHAR (40) NOT NULL,
    [ContactExtension]            NVARCHAR (12) NOT NULL,
    [CreatedDateTime]             DATETIME2 (7) CONSTRAINT [DF_HealthCareProviderContact_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_HealthCareProviderContact_HealthCareProviderContactID] PRIMARY KEY CLUSTERED ([HealthCareProviderContactID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_HealthCareProviderContact_HealthCareProviderID_ContactTypeCodeID_SequenceNumber]
    ON [dbo].[HealthCareProviderContact]([HealthCareProviderID] ASC, [ContactTypeCodeID] ASC, [SequenceNumber] ASC);

