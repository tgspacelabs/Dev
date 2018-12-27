CREATE TABLE [dbo].[Table1] (
    [a] INT NOT NULL,
    [b] INT NULL,
    [c] AS  ([a]+[b]),
    PRIMARY KEY CLUSTERED ([a] ASC) WITH (FILLFACTOR = 100)
);

