CREATE TABLE [dbo].[HealthCareProvider] (
    [HealthCareProviderID] INT           IDENTITY (1, 1) NOT NULL,
    [hcp_typeCodeID]       INT           NULL,
    [LastName]             NVARCHAR (50) NULL,
    [FirstName]            NVARCHAR (50) NULL,
    [MiddleName]           NVARCHAR (50) NULL,
    [degree]               NVARCHAR (20) NULL,
    [VerificationSwitch]   BIT           NOT NULL,
    [doctor_insNumberID]   NVARCHAR (10) NULL,
    [doctor_deaNumber]     NVARCHAR (10) NULL,
    [medicareID]           NVARCHAR (12) NULL,
    [medicaidID]           NVARCHAR (20) NULL,
    [CreatedDateTime]      DATETIME2 (7) CONSTRAINT [DF_HealthCareProvider_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_HealthCareProvider_HealthCareProviderID] PRIMARY KEY CLUSTERED ([HealthCareProviderID] ASC)
);

