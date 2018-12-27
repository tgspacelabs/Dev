CREATE TABLE [dbo].[charge] (
    [charge_no]    [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [member_no]    [dbo].[numeric_id]  NOT NULL,
    [provider_no]  [dbo].[numeric_id]  NOT NULL,
    [category_no]  [dbo].[numeric_id]  NOT NULL,
    [charge_dt]    DATETIME            NOT NULL,
    [charge_amt]   MONEY               NOT NULL,
    [statement_no] [dbo].[numeric_id]  CONSTRAINT [charge_statement_no_default] DEFAULT (0) NOT NULL,
    [charge_code]  [dbo].[status_code] CONSTRAINT [charge_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [ChargePK] PRIMARY KEY CLUSTERED ([charge_no] ASC),
    CONSTRAINT [charge_category_link] FOREIGN KEY ([category_no]) REFERENCES [dbo].[category] ([category_no]),
    CONSTRAINT [charge_member_link] FOREIGN KEY ([member_no]) REFERENCES [dbo].[Member] ([MemberNo]),
    CONSTRAINT [charge_provider_link] FOREIGN KEY ([provider_no]) REFERENCES [dbo].[provider] ([provider_no])
);


GO
CREATE NONCLUSTERED INDEX [charge_category_link]
    ON [dbo].[charge]([category_no] ASC);


GO
CREATE NONCLUSTERED INDEX [charge_provider_link]
    ON [dbo].[charge]([provider_no] ASC);


GO
CREATE NONCLUSTERED INDEX [charge_statement_link]
    ON [dbo].[charge]([statement_no] ASC);

