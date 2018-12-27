CREATE TABLE [dbo].[tblINT_test] (
    [id]         INT        IDENTITY (1, 1) NOT NULL,
    [name]       CHAR (981) NOT NULL,
    [date_stamp] DATETIME   NOT NULL,
    CONSTRAINT [PK_[tblINT_test] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 100)
);

