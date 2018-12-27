CREATE TABLE [dbo].[Actor]
    (
        [ActorID]   INT          IDENTITY(1, 1) NOT NULL,
        [FirstName] NVARCHAR(50) NOT NULL,
        [LastName]  NVARCHAR(50) NOT NULL,
        CONSTRAINT [PK_Actor]
            PRIMARY KEY CLUSTERED ([ActorID] ASC)
    );
