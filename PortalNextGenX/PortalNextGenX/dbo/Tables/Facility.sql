CREATE TABLE [dbo].[Facility] (
    [FacilityID]      INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]  INT           NOT NULL,
    [Name]            NVARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Facility_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED ([FacilityID] ASC),
    CONSTRAINT [FK_Facility_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Facility_Organization_OrganizationID]
    ON [dbo].[Facility]([OrganizationID] ASC);

