CREATE TABLE [dbo].[StatusData] (
    [Id]    UNIQUEIDENTIFIER NOT NULL,
    [SetId] UNIQUEIDENTIFIER NOT NULL,
    [Name]  VARCHAR (25)     NOT NULL,
    [Value] VARCHAR (25)     NULL,
    CONSTRAINT [PK_StatusData_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_StatusData_SetId]
    ON [dbo].[StatusData]([SetId] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StatusData';

