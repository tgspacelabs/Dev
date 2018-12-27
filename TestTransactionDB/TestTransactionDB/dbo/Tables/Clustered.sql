CREATE TABLE [dbo].[Clustered] (
    [ClusterID] INT            IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (50)  NULL,
    [LastName]  NVARCHAR (50)  NULL,
    [City]      NVARCHAR (50)  NULL,
    [State]     NCHAR (2)      NULL,
    [ExtraData] NVARCHAR (MAX) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'This is a test table for checking out clustered index fragmentation.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Clustered';

