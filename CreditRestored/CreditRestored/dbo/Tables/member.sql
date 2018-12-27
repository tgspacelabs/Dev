CREATE TABLE [dbo].[Member] (
    [MemberNo]     [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [lastname]      [dbo].[shortstring] NOT NULL,
    [firstname]     [dbo].[shortstring] NOT NULL,
    [middleinitial] [dbo].[letter]      NULL,
    [street]        [dbo].[shortstring] NOT NULL,
    [city]          [dbo].[shortstring] NOT NULL,
    [state_prov]    [dbo].[statecode]   NOT NULL,
    [country]       [dbo].[countrycode] NOT NULL,
    [mail_code]     [dbo].[mailcode]    NOT NULL,
    [phone_no]      [dbo].[phonenumber] NULL,
    [photograph]    IMAGE               NULL,
    [issue_dt]      DATETIME            CONSTRAINT [member_issue_dt_default] DEFAULT (getdate()) NOT NULL,
    [expr_dt]       DATETIME            CONSTRAINT [member_expr_dt_default] DEFAULT (dateadd(year,1,getdate())) NOT NULL,
    [region_no]     [dbo].[numeric_id]  NOT NULL,
    [corp_no]       [dbo].[numeric_id]  NULL,
    [prev_balance]  MONEY               CONSTRAINT [member_prev_balance_default] DEFAULT (0) NULL,
    [curr_balance]  MONEY               CONSTRAINT [member_curr_balance_default] DEFAULT (0) NULL,
    [member_code]   [dbo].[status_code] CONSTRAINT [member_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [PK_member_ident] PRIMARY KEY CLUSTERED ([MemberNo] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [member_corporation_link] FOREIGN KEY ([corp_no]) REFERENCES [dbo].[corporation] ([corp_no]),
    CONSTRAINT [member_region_link] FOREIGN KEY ([region_no]) REFERENCES [dbo].[region] ([region_no])
);


GO
CREATE NONCLUSTERED INDEX [member_corporation_linkage]
    ON [dbo].[Member]([corp_no] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [member_region_link]
    ON [dbo].[Member]([region_no] ASC) WITH (FILLFACTOR = 80);

