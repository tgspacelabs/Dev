CREATE TABLE [dbo].[ClientMap] (
    [ClientMapID]     INT           IDENTITY (1, 1) NOT NULL,
    [MapType]         NVARCHAR (20) NOT NULL,
    [MapValue]        NVARCHAR (40) NOT NULL,
    [UnitName]        NVARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_ClientMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ClientMap_ClientMapID] PRIMARY KEY CLUSTERED ([ClientMapID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ClientMap_MapType_MapValue]
    ON [dbo].[ClientMap]([MapType] ASC, [MapValue] ASC);

