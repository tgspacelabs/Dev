CREATE TABLE [dbo].[Bed] (
    [BedID]           INT           IDENTITY (1, 1) NOT NULL,
    [RoomID]          INT           NOT NULL,
    [Name]            NVARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Bed_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Bed] PRIMARY KEY CLUSTERED ([BedID] ASC),
    CONSTRAINT [FK_Bed_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [dbo].[Room] ([RoomID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Bed_Room_RoomID]
    ON [dbo].[Bed]([RoomID] ASC);

