CREATE TABLE [dbo].[Person] (
    [personId]   INT           IDENTITY (1, 1) NOT NULL,
    [personName] VARCHAR (100) NULL,
    [companyId]  INT           NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([personId] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_Person_CompanyId] FOREIGN KEY ([companyId]) REFERENCES [dbo].[Company] ([companyId])
);

