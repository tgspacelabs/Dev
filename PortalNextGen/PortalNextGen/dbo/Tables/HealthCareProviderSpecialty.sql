CREATE TABLE [dbo].[HealthCareProviderSpecialty] (
    [HealthCareProviderSpecialtyID] INT           IDENTITY (1, 1) NOT NULL,
    [HealthCareProviderID]          INT           NOT NULL,
    [SpecialtyCodeID]               INT           NOT NULL,
    [GoverningBoard]                NVARCHAR (50) NULL,
    [CertificationCode]             NVARCHAR (20) NULL,
    [CertificationDateTime]         DATETIME2 (7) NULL,
    [CreatedDateTime]               DATETIME2 (7) CONSTRAINT [DF_HealthCareProviderSpecialty_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_HealthCareProviderSpecialty_HealthCareProviderSpecialtyID] PRIMARY KEY CLUSTERED ([HealthCareProviderSpecialtyID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_HealthCareProviderSpecialty_HealthCareProviderid_SpecialtyCodeID]
    ON [dbo].[HealthCareProviderSpecialty]([HealthCareProviderID] ASC, [SpecialtyCodeID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_HealthCareProviderSpecialty_SpecialtyCodeID_HealthCareProviderID]
    ON [dbo].[HealthCareProviderSpecialty]([SpecialtyCodeID] ASC, [HealthCareProviderID] ASC);

