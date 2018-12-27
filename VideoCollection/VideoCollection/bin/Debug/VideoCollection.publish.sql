﻿/*
Deployment script for VideoCollection

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "VideoCollection"
:setvar DefaultFilePrefix "VideoCollection"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Dropping [dbo].[FK_MovieActor_Actor_ActorID]...';


GO
ALTER TABLE [dbo].[MovieActor] DROP CONSTRAINT [FK_MovieActor_Actor_ActorID];


GO
PRINT N'Dropping [dbo].[FK_Movie_Category_CategoryID]...';


GO
ALTER TABLE [dbo].[Movie] DROP CONSTRAINT [FK_Movie_Category_CategoryID];


GO
PRINT N'Dropping [dbo].[FK_Movie_Director_DirectorID]...';


GO
ALTER TABLE [dbo].[Movie] DROP CONSTRAINT [FK_Movie_Director_DirectorID];


GO
PRINT N'Dropping [dbo].[FK_Movie_Medium_MediumID]...';


GO
ALTER TABLE [dbo].[Movie] DROP CONSTRAINT [FK_Movie_Medium_MediumID];


GO
PRINT N'Dropping [dbo].[FK_MovieActor_Movie_MovieID]...';


GO
ALTER TABLE [dbo].[MovieActor] DROP CONSTRAINT [FK_MovieActor_Movie_MovieID];


GO
PRINT N'Starting rebuilding table [dbo].[Actor]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Actor] (
    [ActorID]   INT           IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [LastName]  NVARCHAR (50) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Actor1] PRIMARY KEY CLUSTERED ([ActorID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Actor])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Actor] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Actor] ([ActorID], [FirstName], [LastName])
        SELECT   [ActorID],
                 [FirstName],
                 [LastName]
        FROM     [dbo].[Actor]
        ORDER BY [ActorID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Actor] OFF;
    END

DROP TABLE [dbo].[Actor];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Actor]', N'Actor';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Actor1]', N'PK_Actor', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Category]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Category] (
    [CategoryID] SMALLINT       IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Category1] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Category])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Category] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Category] ([CategoryID], [Name])
        SELECT   [CategoryID],
                 [Name]
        FROM     [dbo].[Category]
        ORDER BY [CategoryID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Category] OFF;
    END

DROP TABLE [dbo].[Category];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Category]', N'Category';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Category1]', N'PK_Category', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Director]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Director] (
    [DirectorID] INT            IDENTITY (1, 1) NOT NULL,
    [Director]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Director1] PRIMARY KEY CLUSTERED ([DirectorID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Director])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Director] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Director] ([DirectorID], [Director])
        SELECT   [DirectorID],
                 [Director]
        FROM     [dbo].[Director]
        ORDER BY [DirectorID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Director] OFF;
    END

DROP TABLE [dbo].[Director];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Director]', N'Director';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Director1]', N'PK_Director', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Genre]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Genre] (
    [GenreID] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [Genre]   VARCHAR (50) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Genre1] PRIMARY KEY CLUSTERED ([GenreID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Genre])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Genre] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Genre] ([GenreID], [Genre])
        SELECT   [GenreID],
                 [Genre]
        FROM     [dbo].[Genre]
        ORDER BY [GenreID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Genre] OFF;
    END

DROP TABLE [dbo].[Genre];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Genre]', N'Genre';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Genre1]', N'PK_Genre', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Medium]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Medium] (
    [MediumID] TINYINT       IDENTITY (1, 1) NOT NULL,
    [Format]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Medium1] PRIMARY KEY CLUSTERED ([MediumID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Medium])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Medium] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Medium] ([MediumID], [Format])
        SELECT   [MediumID],
                 [Format]
        FROM     [dbo].[Medium]
        ORDER BY [MediumID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Medium] OFF;
    END

DROP TABLE [dbo].[Medium];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Medium]', N'Medium';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Medium1]', N'PK_Medium', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Movie]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Movie] (
    [MovieID]       INT            IDENTITY (1, 1) NOT NULL,
    [Title]         NVARCHAR (255) NOT NULL,
    [CategoryID]    SMALLINT       NOT NULL,
    [YearOfRelease] SMALLINT       NOT NULL,
    [LengthMinutes] SMALLINT       NOT NULL,
    [DirectorID]    INT            NOT NULL,
    [MediumID]      TINYINT        NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Movie1] PRIMARY KEY CLUSTERED ([MovieID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Movie])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Movie] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Movie] ([MovieID], [Title], [CategoryID], [YearOfRelease], [LengthMinutes], [DirectorID], [MediumID])
        SELECT   [MovieID],
                 [Title],
                 [CategoryID],
                 [YearOfRelease],
                 [LengthMinutes],
                 [DirectorID],
                 [MediumID]
        FROM     [dbo].[Movie]
        ORDER BY [MovieID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Movie] OFF;
    END

DROP TABLE [dbo].[Movie];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Movie]', N'Movie';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Movie1]', N'PK_Movie', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[MovieActor]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_MovieActor] (
    [MovieActorID] INT IDENTITY (1, 1) NOT NULL,
    [MovieID]      INT NOT NULL,
    [ActorID]      INT NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_MovieActor1] PRIMARY KEY CLUSTERED ([MovieActorID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[MovieActor])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_MovieActor] ON;
        INSERT INTO [dbo].[tmp_ms_xx_MovieActor] ([MovieActorID], [MovieID], [ActorID])
        SELECT   [MovieActorID],
                 [MovieID],
                 [ActorID]
        FROM     [dbo].[MovieActor]
        ORDER BY [MovieActorID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_MovieActor] OFF;
    END

DROP TABLE [dbo].[MovieActor];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_MovieActor]', N'MovieActor';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_MovieActor1]', N'PK_MovieActor', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_MovieActor_Actor_ActorID]...';


GO
ALTER TABLE [dbo].[MovieActor] WITH NOCHECK
    ADD CONSTRAINT [FK_MovieActor_Actor_ActorID] FOREIGN KEY ([ActorID]) REFERENCES [dbo].[Actor] ([ActorID]);


GO
PRINT N'Creating [dbo].[FK_Movie_Category_CategoryID]...';


GO
ALTER TABLE [dbo].[Movie] WITH NOCHECK
    ADD CONSTRAINT [FK_Movie_Category_CategoryID] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID]);


GO
PRINT N'Creating [dbo].[FK_Movie_Director_DirectorID]...';


GO
ALTER TABLE [dbo].[Movie] WITH NOCHECK
    ADD CONSTRAINT [FK_Movie_Director_DirectorID] FOREIGN KEY ([DirectorID]) REFERENCES [dbo].[Director] ([DirectorID]);


GO
PRINT N'Creating [dbo].[FK_Movie_Medium_MediumID]...';


GO
ALTER TABLE [dbo].[Movie] WITH NOCHECK
    ADD CONSTRAINT [FK_Movie_Medium_MediumID] FOREIGN KEY ([MediumID]) REFERENCES [dbo].[Medium] ([MediumID]);


GO
PRINT N'Creating [dbo].[FK_MovieActor_Movie_MovieID]...';


GO
ALTER TABLE [dbo].[MovieActor] WITH NOCHECK
    ADD CONSTRAINT [FK_MovieActor_Movie_MovieID] FOREIGN KEY ([MovieID]) REFERENCES [dbo].[Movie] ([MovieID]);


GO