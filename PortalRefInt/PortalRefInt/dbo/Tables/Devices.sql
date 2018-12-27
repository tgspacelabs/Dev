CREATE TABLE [dbo].[Devices] (
    [Id]          BIGINT NOT NULL,
    [Name]        VARCHAR (50)     NOT NULL,
    [Description] VARCHAR (50)     NULL,
    [Room]        VARCHAR (12)     NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Devices';

