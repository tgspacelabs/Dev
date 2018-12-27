CREATE TABLE [dbo].[Devices] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Name]        VARCHAR (50)     NOT NULL,
    [Description] VARCHAR (50)     NULL,
    [Room]        VARCHAR (12)     NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_Devices_Id]
    ON [dbo].[Devices]([Id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Devices_Name]
    ON [dbo].[Devices]([Name] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Devices';

