CREATE TABLE [dbo].[payment] (
    [payment_no]   [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [member_no]    [dbo].[numeric_id]  NOT NULL,
    [payment_dt]   DATETIME            NOT NULL,
    [payment_amt]  MONEY               NOT NULL,
    [statement_no] [dbo].[numeric_id]  CONSTRAINT [payment_statement_no_default] DEFAULT (0) NULL,
    [payment_code] [dbo].[status_code] CONSTRAINT [payment_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [payment_ident] PRIMARY KEY NONCLUSTERED ([payment_no] ASC),
    CONSTRAINT [payment_amount_rule] CHECK ([payment_amt] <> 0),
    CONSTRAINT [payment_member_link] FOREIGN KEY ([member_no]) REFERENCES [dbo].[Member] ([MemberNo])
);


GO
CREATE NONCLUSTERED INDEX [payment_member_link]
    ON [dbo].[payment]([member_no] ASC);

