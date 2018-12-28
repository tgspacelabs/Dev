CREATE TABLE [dbo].[HealthCareProviderMap] (
    [HealthCareProviderMapID] INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]          INT           NOT NULL,
    [HealthCareProviderXID]   NVARCHAR (20) NOT NULL,
    [HealthCareProviderID]    INT           NOT NULL,
    [CreatedDateTime]         DATETIME2 (7) CONSTRAINT [DF_HealthCareProviderMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_HealthCareProviderMap_HealthCareProviderMapID] PRIMARY KEY CLUSTERED ([HealthCareProviderMapID] ASC),
    CONSTRAINT [FK_HealthCareProviderMap_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_intHealthCareProvidermap_OrganizationID_HealthCareProviderXID]
    ON [dbo].[HealthCareProviderMap]([OrganizationID] ASC, [HealthCareProviderXID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_HealthCareProviderMap_Organization_OrganizationID]
    ON [dbo].[HealthCareProviderMap]([OrganizationID] ASC);

