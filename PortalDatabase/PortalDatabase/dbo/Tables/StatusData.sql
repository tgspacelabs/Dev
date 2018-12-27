CREATE TABLE [dbo].[StatusData] (
    [Id]    UNIQUEIDENTIFIER NOT NULL,
    [SetId] UNIQUEIDENTIFIER NOT NULL,
    [Name]  VARCHAR (25)     NOT NULL,
    [Value] VARCHAR (25)     NULL,
    CONSTRAINT [PK_StatusData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE CLUSTERED INDEX [CL_StatusData_SetId]
    ON [dbo].[StatusData]([SetId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_StatusData_Name_SetId_Value]
    ON [dbo].[StatusData]([Name] ASC)
    INCLUDE([SetId], [Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_StatusData_SetId_Name_Id_Value]
    ON [dbo].[StatusData]([SetId] ASC, [Name] ASC)
    INCLUDE([Id], [Value]) WHERE ([StatusData].[Name] IN ('lead1Index', 'lead2Index')) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Status Data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StatusData';

