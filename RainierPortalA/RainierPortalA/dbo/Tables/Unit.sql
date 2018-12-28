CREATE TABLE [dbo].[Unit] (
    [UnitID]          INT           IDENTITY (1, 1) NOT NULL,
    [FacilityID]      INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Unit_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK__Unit__44F5EC9533DCF7A4] PRIMARY KEY CLUSTERED ([UnitID] ASC),
    CONSTRAINT [FK_Unit_Facility_FacilityID] FOREIGN KEY ([FacilityID]) REFERENCES [dbo].[Facility] ([FacilityID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Unit_Facility_FacilityID]
    ON [dbo].[Unit]([FacilityID] ASC);

