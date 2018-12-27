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
PRINT N'Altering [dbo].[Performance]...';


GO
ALTER TABLE [dbo].[Performance] DROP COLUMN [RowsPerSecond];


GO
ALTER TABLE [dbo].[Performance]
    ADD [RowsPerSecond] AS CAST (ROUND(([BatchSize] * [NumberOfBatches]) / ([ElapsedTimeMs] * 1.0), 0) AS DECIMAL (10, 0)) PERSISTED;


GO
PRINT N'Refreshing [dbo].[uspInsertWaveforms]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[uspInsertWaveforms]';


GO
PRINT N'Update complete.';


GO
