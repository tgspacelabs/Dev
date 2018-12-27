CREATE TABLE [dbo].[member2] (
    [member_no]     [dbo].[numeric_id]  NOT NULL,
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
    [issue_dt]      DATETIME            NOT NULL,
    [expr_dt]       DATETIME            NOT NULL,
    [region_no]     [dbo].[numeric_id]  NOT NULL,
    [corp_no]       [dbo].[numeric_id]  NULL,
    [prev_balance]  MONEY               NULL,
    [curr_balance]  MONEY               NULL,
    [member_code]   [dbo].[status_code] NOT NULL,
    CONSTRAINT [member2PK] PRIMARY KEY CLUSTERED ([member_no] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_member2_lastname_firstname_middleinitial]
    ON [dbo].[member2]([lastname] ASC, [firstname] ASC, [middleinitial] ASC);


GO
CREATE NONCLUSTERED INDEX [member2CorpFK]
    ON [dbo].[member2]([corp_no] ASC);


GO
CREATE NONCLUSTERED INDEX [member2RegionFK]
    ON [dbo].[member2]([region_no] ASC);

