CREATE TABLE [dbo].[Person] (
    [PersonID]         INT           IDENTITY (1, 1) NOT NULL,
    [NewPatientID]     INT           NULL,
    [FirstName]        NVARCHAR (50) NULL,
    [MiddleName]       NVARCHAR (50) NULL,
    [LastName]         NVARCHAR (50) NULL,
    [Suffix]           NVARCHAR (5)  NULL,
    [TelephoneNumber]  NVARCHAR (40) NULL,
    [Line1Description] NVARCHAR (80) NULL,
    [Line2Description] NVARCHAR (80) NULL,
    [Line3Description] NVARCHAR (80) NULL,
    [City]             NVARCHAR (30) NULL,
    [StateCode]        NVARCHAR (3)  NULL,
    [ZipCode]          NVARCHAR (15) NULL,
    [CountryCodeID]    INT           NULL,
    [CreatedDateTime]  DATETIME2 (7) CONSTRAINT [DF_Person_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Person_PersonID] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Person_PersonID_FirstName_LastName]
    ON [dbo].[Person]([PersonID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Person_PersonID]
    ON [dbo].[Person]([PersonID] ASC);

