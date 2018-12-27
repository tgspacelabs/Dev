CREATE TABLE [dbo].[tblGUID_test] (
    [id]         UNIQUEIDENTIFIER NOT NULL,
    [name]       CHAR (969)       NOT NULL,
    [date_stamp] DATETIME         NOT NULL,
    CONSTRAINT [PK_tblGUID_test] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 100)
);

