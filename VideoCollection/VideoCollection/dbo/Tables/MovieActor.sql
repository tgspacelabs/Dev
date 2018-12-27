CREATE TABLE [dbo].[MovieActor]
    (
        [MovieActorID] INT IDENTITY(1, 1) NOT NULL,
        [MovieID]      INT NOT NULL,
        [ActorID]      INT NOT NULL,
        CONSTRAINT [PK_MovieActor]
            PRIMARY KEY CLUSTERED ([MovieActorID] ASC),
        CONSTRAINT [FK_MovieActor_Actor_ActorID]
            FOREIGN KEY ([ActorID])
            REFERENCES [dbo].[Actor] ([ActorID]),
        CONSTRAINT [FK_MovieActor_Movie_MovieID]
            FOREIGN KEY ([MovieID])
            REFERENCES [dbo].[Movie] ([MovieID])
    );

