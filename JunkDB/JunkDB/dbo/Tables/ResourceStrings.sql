CREATE TABLE [dbo].[ResourceStrings] (
    [Locale]  NVARCHAR (50)  NOT NULL,
    [Name]    NVARCHAR (250) NOT NULL,
    [Value]   NVARCHAR (250) NULL,
    [Comment] NVARCHAR (250) NULL,
    CONSTRAINT [PK_ResourceStrings_Locale_Name] PRIMARY KEY CLUSTERED ([Locale] ASC, [Name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ResourceStrings_Locale_Name_Value]
    ON [dbo].[ResourceStrings]([Locale] ASC, [Name] ASC)
    INCLUDE([Value]);

