CREATE TABLE [dbo].[Devices] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Name]        VARCHAR (50)     NOT NULL,
    [Description] VARCHAR (50)     NULL,
    [Room]        VARCHAR (12)     NULL
);

