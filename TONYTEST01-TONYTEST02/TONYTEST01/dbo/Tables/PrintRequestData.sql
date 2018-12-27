CREATE TABLE [dbo].[PrintRequestData] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [PrintRequestId] UNIQUEIDENTIFIER NOT NULL,
    [Name]           VARCHAR (50)     NULL,
    [Value]          VARCHAR (MAX)    NULL
);

