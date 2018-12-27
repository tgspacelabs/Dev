CREATE TABLE [dbo].[Company] (
    [companyId]   INT           IDENTITY (1, 1) NOT NULL,
    [companyName] VARCHAR (100) NULL,
    [zipcode]     VARCHAR (10)  NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([companyId] ASC) WITH (FILLFACTOR = 100)
);

