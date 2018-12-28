CREATE TABLE [dbo].[Room] (
    [RoomID]          INT           IDENTITY (1, 1) NOT NULL,
    [FacilityID]      INT           NOT NULL,
    [Name]            NVARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Room_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Room_RoomID] PRIMARY KEY CLUSTERED ([RoomID] ASC),
    CONSTRAINT [FK_Room_Facility_FacilityID] FOREIGN KEY ([FacilityID]) REFERENCES [dbo].[Facility] ([FacilityID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Room_Facility_FacilityID]
    ON [dbo].[Room]([FacilityID] ASC);

