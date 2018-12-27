CREATE TABLE [dbo].[People] (
    [PersonID]   INT          IDENTITY (1, 1) NOT NULL,
    [PersonName] VARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([PersonID] ASC) WITH (FILLFACTOR = 100)
);

