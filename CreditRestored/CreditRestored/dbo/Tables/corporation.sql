CREATE TABLE [dbo].[corporation] (
    [corp_no]    [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [corp_name]  [dbo].[normstring]  NOT NULL,
    [street]     [dbo].[shortstring] NOT NULL,
    [city]       [dbo].[shortstring] NOT NULL,
    [state_prov] [dbo].[statecode]   NOT NULL,
    [country]    [dbo].[countrycode] NOT NULL,
    [mail_code]  [dbo].[mailcode]    NOT NULL,
    [phone_no]   [dbo].[phonenumber] NOT NULL,
    [expr_dt]    DATETIME            NOT NULL,
    [region_no]  [dbo].[numeric_id]  NOT NULL,
    [corp_code]  [dbo].[status_code] CONSTRAINT [corporation_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [corporation_ident] PRIMARY KEY CLUSTERED ([corp_no] ASC),
    CONSTRAINT [corporation_region_link] FOREIGN KEY ([region_no]) REFERENCES [dbo].[region] ([region_no])
);


GO
CREATE NONCLUSTERED INDEX [corporation_region_link]
    ON [dbo].[corporation]([region_no] ASC);

