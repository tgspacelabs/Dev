CREATE TABLE [dbo].[Table3] (
    [Table1ID]    INT            NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    [UpdatedDate] DATETIME2 (7)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Table1ID] ASC) WITH (FILLFACTOR = 100)
);

