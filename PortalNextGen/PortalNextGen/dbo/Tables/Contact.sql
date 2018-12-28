CREATE TABLE [dbo].[Contact] (
    [ContactID]       INT           IDENTITY (1, 1) NOT NULL,
    [UserID]          INT           NOT NULL,
    [Description]     NVARCHAR (80) NOT NULL,
    [PhoneNumber]     NVARCHAR (80) NULL,
    [Address1]        NVARCHAR (80) NULL,
    [Address2]        NVARCHAR (80) NULL,
    [Address3]        NVARCHAR (80) NULL,
    [Email]           NVARCHAR (40) NULL,
    [City]            NVARCHAR (50) NULL,
    [StateProvince]   NVARCHAR (30) NULL,
    [PostalCode]      NVARCHAR (15) NULL,
    [Country]         NVARCHAR (20) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Contact_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Contact_ContactID] PRIMARY KEY CLUSTERED ([ContactID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [FK_Contact_User_UserID]
    ON [dbo].[Contact]([UserID] ASC);

