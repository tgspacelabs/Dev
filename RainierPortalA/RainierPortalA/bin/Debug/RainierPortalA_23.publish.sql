﻿/*
Deployment script for RainierPortalA

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "RainierPortalA"
:setvar DefaultFilePrefix "RainierPortalA"
:setvar DefaultDataPath "D:\SQLDATA16\"
:setvar DefaultLogPath "E:\SQLLOG16\"

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
----------------------------------------------------------------------------------------
-- © Copyright 2017 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

/*
 Pre-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.    
 Use SQLCMD syntax to include a file in the pre-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the pre-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/

GO

GO
PRINT N'Dropping [dbo].[DF_DeviceParameter_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[DeviceParameter] DROP CONSTRAINT [DF_DeviceParameter_CreatedDateTime];


GO
PRINT N'Dropping [dbo].[FK_DeviceParameter_Parameter_ParameterID]...';


GO
ALTER TABLE [dbo].[DeviceParameter] DROP CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID];


GO
PRINT N'Dropping [dbo].[FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID]...';


GO
ALTER TABLE [dbo].[DeviceParameter] DROP CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID];


GO
PRINT N'Starting rebuilding table [dbo].[DeviceParameter]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_DeviceParameter] (
    [DeviceParameterID] BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [DeviceID]          BIGINT        NOT NULL,
    [ParameterID]       BIGINT        NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_DeviceParameter_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_DeviceParameter_DeviceParameterID1] PRIMARY KEY CLUSTERED ([DeviceParameterID] ASC) WITH (FILLFACTOR = 100)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[DeviceParameter])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DeviceParameter] ON;
        INSERT INTO [dbo].[tmp_ms_xx_DeviceParameter] ([DeviceParameterID], [DeviceID], [ParameterID], [CreatedDateTime])
        SELECT   [DeviceParameterID],
                 [DeviceID],
                 [ParameterID],
                 [CreatedDateTime]
        FROM     [dbo].[DeviceParameter]
        ORDER BY [DeviceParameterID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DeviceParameter] OFF;
    END

DROP TABLE [dbo].[DeviceParameter];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_DeviceParameter]', N'DeviceParameter';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_DeviceParameter_DeviceParameterID1]', N'PK_DeviceParameter_DeviceParameterID', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_DeviceParameter_Parameter_ParameterID]...';


GO
ALTER TABLE [dbo].[DeviceParameter] WITH NOCHECK
    ADD CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
PRINT N'Creating [dbo].[FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID]...';


GO
ALTER TABLE [dbo].[DeviceParameter] WITH NOCHECK
    ADD CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([DeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID]);


GO
----------------------------------------------------------------------------------------
-- © Copyright 2017 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/

PRINT N'Begin - Post-Deployment script...';
GO

USE [$(DatabaseName)];
GO

----------------------------------------------------------------------------------------
-- © Copyright 2017 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

PRINT N'Loading data for [dbo].[Gender]...';

--
-- Data for table dbo.Gender
--

IF OBJECT_ID('tempdb..#Gender') IS NOT NULL
    BEGIN
        DROP TABLE [#Gender];
    END;
GO

CREATE TABLE [#Gender]
    (
        [GenderID] TINYINT NOT NULL PRIMARY KEY CLUSTERED,
        [Name]     VARCHAR(50)
            DEFAULT ('') NOT NULL,
    );
GO

INSERT INTO [#Gender]
    (
        [GenderID],
        [Name]
    )
VALUES
    (
        1, 'Male' -- Name - varchar(50)
    );
GO

INSERT INTO [#Gender]
    (
        [GenderID],
        [Name]
    )
VALUES
    (
        2, 'Female' -- Name - varchar(50)
    );
GO

INSERT INTO [#Gender]
    (
        [GenderID],
        [Name]
    )
VALUES
    (
        3, 'Other' -- Name - varchar(50)
    );
GO

SET IDENTITY_INSERT [dbo].[Gender] ON;
GO

INSERT INTO [dbo].[Gender]
    (
        [GenderID],
        [Name]
    )
            SELECT
                [g].[GenderID],
                [g].[Name]
            FROM
                [#Gender]          AS [g]
                LEFT OUTER JOIN
                    [dbo].[Gender] AS [g2]
                        ON [g].[GenderID] = [g2].[GenderID]
            WHERE
                [g2].[GenderID] IS NULL;
GO

SET IDENTITY_INSERT [dbo].[Gender] OFF;
GO

IF OBJECT_ID('tempdb..#Gender') IS NOT NULL
    BEGIN
        DROP TABLE [#Gender];
    END;
GO


-- Rebuild indexes on static data tables to reduce fragmentation

----------------------------------------------------------------------------------------
-- © Copyright 2017 Spacelabs Healthcare, Inc.
--
-- This material contains proprietary, trade secret, and confidential information
-- which is the property of Spacelabs Healthcare. This material and the information
-- it contains are not to be copied, distributed, or disclosed to others without the
-- prior written approval of Spacelabs Healthcare.
--
----------------------------------------------------------------------------------------

PRINT N'Begin - Rebuilding indexes on static data tables to reduce fragmentation...';
GO

ALTER INDEX ALL
    ON [dbo].[Gender]
    REBUILD
    WITH (FILLFACTOR = 100);
GO

PRINT N'End - Rebuilding indexes on static data tables to reduce fragmentation...';
GO


PRINT N'End - Post-Deployment script...';
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[DeviceParameter] WITH CHECK CHECK CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID];

ALTER TABLE [dbo].[DeviceParameter] WITH CHECK CHECK CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID];


GO
PRINT N'Update complete.';


GO
