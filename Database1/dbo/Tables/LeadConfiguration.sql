CREATE TABLE [dbo].[LeadConfiguration] (
    [LeadName]           NVARCHAR (50) NOT NULL,
    [MonitorLoaderValue] VARCHAR (20)  NULL,
    [DataLoaderValue]    VARCHAR (20)  NULL,
    CONSTRAINT [PK_LeadConfiguration_LeadName] PRIMARY KEY CLUSTERED ([LeadName] ASC) WITH (FILLFACTOR = 100)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LeadConfiguration';

