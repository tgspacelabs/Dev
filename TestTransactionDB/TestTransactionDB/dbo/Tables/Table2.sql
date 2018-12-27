CREATE TABLE [dbo].[Table2] (
    [x] INT NOT NULL,
    [y] INT NOT NULL,
    [a] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([x] ASC, [y] ASC),
    CONSTRAINT [FK_Table2_Table1] FOREIGN KEY ([a]) REFERENCES [dbo].[Table1] ([a])
);

