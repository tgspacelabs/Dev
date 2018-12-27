CREATE TABLE [dbo].[provider] (
    [provider_no]   [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [provider_name] [dbo].[shortstring] NOT NULL,
    [street]        [dbo].[shortstring] NOT NULL,
    [city]          [dbo].[shortstring] NOT NULL,
    [state_prov]    [dbo].[statecode]   NOT NULL,
    [mail_code]     [dbo].[mailcode]    NOT NULL,
    [country]       [dbo].[countrycode] NOT NULL,
    [phone_no]      [dbo].[phonenumber] NOT NULL,
    [issue_dt]      DATETIME            CONSTRAINT [provider_issue_dt_default] DEFAULT (getdate()) NOT NULL,
    [expr_dt]       DATETIME            CONSTRAINT [provider_expr_dt_default] DEFAULT (dateadd(year,1,getdate())) NOT NULL,
    [region_no]     [dbo].[numeric_id]  NOT NULL,
    [provider_code] [dbo].[status_code] CONSTRAINT [provider_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [provider_ident] PRIMARY KEY CLUSTERED ([provider_no] ASC),
    CONSTRAINT [provider_region_link] FOREIGN KEY ([region_no]) REFERENCES [dbo].[region] ([region_no])
);


GO
CREATE NONCLUSTERED INDEX [provider_region_link]
    ON [dbo].[provider]([region_no] ASC);

