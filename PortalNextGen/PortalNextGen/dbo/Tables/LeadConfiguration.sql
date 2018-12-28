CREATE TABLE [dbo].[LeadConfiguration] (
    [LeadConfigurationID] INT           IDENTITY (1, 1) NOT NULL,
    [LeadName]            NVARCHAR (50) NULL,
    [MonitorLoaderValue]  VARCHAR (20)  NULL,
    [DataLoaderValue]     VARCHAR (20)  NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_LeadConfiguration_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LeadConfiguration_LeadConfigurationID] PRIMARY KEY CLUSTERED ([LeadConfigurationID] ASC)
);

