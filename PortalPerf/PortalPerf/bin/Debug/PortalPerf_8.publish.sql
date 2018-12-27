﻿/*
Deployment script for PortalPerf

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PortalPerf"
:setvar DefaultFilePrefix "PortalPerf"
:setvar DefaultDataPath "D:\SQLDATA\"
:setvar DefaultLogPath "E:\SQLLOG\"

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
USE [$(DatabaseName)];


GO
PRINT N'Dropping [dbo].[DF_Performance_ServerName]...';


GO
ALTER TABLE [dbo].[Performance] DROP CONSTRAINT [DF_Performance_ServerName];


GO
PRINT N'Dropping [dbo].[DF_Performance_ServerType]...';


GO
ALTER TABLE [dbo].[Performance] DROP CONSTRAINT [DF_Performance_ServerType];


GO
PRINT N'Dropping [dbo].[DF_Performance_ServerVersion]...';


GO
ALTER TABLE [dbo].[Performance] DROP CONSTRAINT [DF_Performance_ServerVersion];


GO
PRINT N'Dropping [dbo].[DF_Performance_BytesPerRow]...';


GO
ALTER TABLE [dbo].[Performance] DROP CONSTRAINT [DF_Performance_BytesPerRow];


GO
PRINT N'Dropping [dbo].[DF_Performance_Compressed]...';


GO
ALTER TABLE [dbo].[Performance] DROP CONSTRAINT [DF_Performance_Compressed];


GO
PRINT N'Starting rebuilding table [dbo].[Performance]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Performance] (
    [PerformanceID]    INT            IDENTITY (1, 1) NOT NULL,
    [ServerName]       VARCHAR (128)  CONSTRAINT [DF_Performance_ServerName] DEFAULT (@@SERVERNAME) NOT NULL,
    [ServerType]       VARCHAR (50)   CONSTRAINT [DF_Performance_ServerType] DEFAULT ('Virtual') NOT NULL,
    [ServerVersion]    VARCHAR (255)  CONSTRAINT [DF_Performance_ServerVersion] DEFAULT (@@VERSION) NOT NULL,
    [Name]             [sysname]      NOT NULL,
    [BatchSize]        INT            NOT NULL,
    [NumberOfBatches]  INT            NOT NULL,
    [BytesPerRow]      INT            CONSTRAINT [DF_Performance_BytesPerRow] DEFAULT (20000) NOT NULL,
    [ElapsedTimeMs]    DECIMAL (9, 3) NOT NULL,
    [TotalRowsInTable] BIGINT         NOT NULL,
    [Compressed]       VARCHAR (5)    CONSTRAINT [DF_Performance_Compressed] DEFAULT ('No') NOT NULL,
    [RowsPerSecond]    AS             CAST (ROUND(([BatchSize] * [NumberOfBatches]) / ([ElapsedTimeMs] * 1.0), 0) AS DECIMAL (10, 0)) PERSISTED,
    [Created]          DATETIME2 (7)  CONSTRAINT [DF_Performance_Created] DEFAULT (SYSDATETIME()) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Performance_PerformanceID1] PRIMARY KEY CLUSTERED ([PerformanceID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Performance])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Performance] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Performance] ([PerformanceID], [ServerName], [ServerType], [ServerVersion], [Name], [BatchSize], [NumberOfBatches], [BytesPerRow], [ElapsedTimeMs], [TotalRowsInTable], [Compressed])
        SELECT   [PerformanceID],
                 [ServerName],
                 [ServerType],
                 [ServerVersion],
                 [Name],
                 [BatchSize],
                 [NumberOfBatches],
                 [BytesPerRow],
                 [ElapsedTimeMs],
                 [TotalRowsInTable],
                 [Compressed]
        FROM     [dbo].[Performance]
        ORDER BY [PerformanceID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Performance] OFF;
    END

DROP TABLE [dbo].[Performance];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Performance]', N'Performance';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Performance_PerformanceID1]', N'PK_Performance_PerformanceID', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Refreshing [dbo].[uspInsertWaveforms]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[uspInsertWaveforms]';


GO
PRINT N'Update complete.';


GO
