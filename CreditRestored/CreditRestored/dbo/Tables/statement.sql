CREATE TABLE [dbo].[statement] (
    [statement_no]   [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [member_no]      [dbo].[numeric_id]  NOT NULL,
    [statement_dt]   DATETIME            NOT NULL,
    [due_dt]         DATETIME            NOT NULL,
    [statement_amt]  MONEY               NOT NULL,
    [statement_code] [dbo].[status_code] CONSTRAINT [statement_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [statement_ident] PRIMARY KEY CLUSTERED ([statement_no] ASC),
    CONSTRAINT [statement_dt_rule] CHECK ([due_dt] >= [statement_dt]),
    CONSTRAINT [statement_member_link] FOREIGN KEY ([member_no]) REFERENCES [dbo].[Member] ([MemberNo])
);


GO
CREATE NONCLUSTERED INDEX [statement_member_link]
    ON [dbo].[statement]([member_no] ASC);

