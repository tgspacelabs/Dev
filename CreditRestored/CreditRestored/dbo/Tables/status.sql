CREATE TABLE [dbo].[status] (
    [status_code] [dbo].[status_code] NOT NULL,
    [status_desc] [dbo].[normstring]  NOT NULL,
    CONSTRAINT [status_ident] PRIMARY KEY CLUSTERED ([status_code] ASC)
);

