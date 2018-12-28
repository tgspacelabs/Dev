﻿CREATE TABLE [dbo].[Room] (
    [RoomID]          INT           IDENTITY (1, 1) NOT NULL,
    [UnitID]          INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Room_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Room_RoomID] PRIMARY KEY CLUSTERED ([RoomID] ASC),
    CONSTRAINT [FK_Room_Unit_UnitID] FOREIGN KEY ([UnitID]) REFERENCES [dbo].[Unit] ([UnitID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Room_Unit_UnitID]
    ON [dbo].[Room]([UnitID] ASC);

