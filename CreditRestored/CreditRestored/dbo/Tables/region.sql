CREATE TABLE [dbo].[region] (
    [region_no]   [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [region_name] [dbo].[shortstring] NOT NULL,
    [street]      [dbo].[shortstring] NOT NULL,
    [city]        [dbo].[shortstring] NOT NULL,
    [state_prov]  [dbo].[statecode]   NOT NULL,
    [country]     [dbo].[countrycode] NOT NULL,
    [mail_code]   [dbo].[mailcode]    NOT NULL,
    [phone_no]    [dbo].[phonenumber] NOT NULL,
    [region_code] [dbo].[status_code] CONSTRAINT [region_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [region_ident] PRIMARY KEY CLUSTERED ([region_no] ASC)
);

