CREATE TABLE [dbo].[FamilyMemberPets] (
    [Name] [sysname] NOT NULL,
    [Pet]  [sysname] NOT NULL,
    PRIMARY KEY CLUSTERED ([Name] ASC, [Pet] ASC) WITH (FILLFACTOR = 100)
);

