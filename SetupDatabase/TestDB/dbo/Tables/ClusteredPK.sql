CREATE TABLE [dbo].[ClusteredPK] (
    [ClusterID] INT            IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (50)  NULL,
    [LastName]  NVARCHAR (50)  NULL,
    [City]      NVARCHAR (50)  NULL,
    [State]     NCHAR (2)      NULL,
    [ExtraData] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([ClusterID] ASC) WITH (FILLFACTOR = 100)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'This is the clustered index and primary key for the test table for checking out clustered index fragmentation.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClusteredPK';

