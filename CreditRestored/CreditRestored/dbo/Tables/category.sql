CREATE TABLE [dbo].[category] (
    [category_no]   [dbo].[numeric_id]  IDENTITY (1, 1) NOT NULL,
    [category_desc] [dbo].[normstring]  NOT NULL,
    [category_code] [dbo].[status_code] CONSTRAINT [category_status_default] DEFAULT ('  ') NOT NULL,
    CONSTRAINT [category_ident] PRIMARY KEY CLUSTERED ([category_no] ASC)
);

