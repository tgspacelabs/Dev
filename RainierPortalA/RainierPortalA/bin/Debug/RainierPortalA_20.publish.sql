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
PRINT N'Dropping [dbo].[DF_Encounter_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Encounter] DROP CONSTRAINT [DF_Encounter_CreatedDateTime];


GO
PRINT N'Dropping [dbo].[FK_DeviceSession_Encounter_EncounterID]...';


GO
ALTER TABLE [dbo].[DeviceSession] DROP CONSTRAINT [FK_DeviceSession_Encounter_EncounterID];


GO
PRINT N'Dropping [dbo].[FK_Encounter_Patient_PatientID]...';


GO
ALTER TABLE [dbo].[Encounter] DROP CONSTRAINT [FK_Encounter_Patient_PatientID];


GO
/*
The column [dbo].[Encounter].[BedID] on table [dbo].[Encounter] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/
GO
PRINT N'Starting rebuilding table [dbo].[Encounter]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Encounter] (
    [EncounterID]     INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]       BIGINT        NOT NULL,
    [BedID]           INT           NOT NULL,
    [BeginDateTime]   DATETIME2 (7) NOT NULL,
    [EndDateTime]     DATETIME2 (7) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Encounter_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Encounter_EncounterID1] PRIMARY KEY CLUSTERED ([EncounterID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Encounter])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Encounter] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Encounter] ([EncounterID], [PatientID], [BeginDateTime], [EndDateTime], [CreatedDateTime])
        SELECT   [EncounterID],
                 [PatientID],
                 [BeginDateTime],
                 [EndDateTime],
                 [CreatedDateTime]
        FROM     [dbo].[Encounter]
        ORDER BY [EncounterID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Encounter] OFF;
    END

DROP TABLE [dbo].[Encounter];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Encounter]', N'Encounter';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Encounter_EncounterID1]', N'PK_Encounter_EncounterID', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[FK_DeviceSession_Encounter_EncounterID]...';


GO
ALTER TABLE [dbo].[DeviceSession] WITH NOCHECK
    ADD CONSTRAINT [FK_DeviceSession_Encounter_EncounterID] FOREIGN KEY ([EncounterID]) REFERENCES [dbo].[Encounter] ([EncounterID]);


GO
PRINT N'Creating [dbo].[FK_Encounter_Patient_PatientID]...';


GO
ALTER TABLE [dbo].[Encounter] WITH NOCHECK
    ADD CONSTRAINT [FK_Encounter_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]);


GO
PRINT N'Creating [dbo].[FK_Encounter_Bed_BedID]...';


GO
ALTER TABLE [dbo].[Encounter] WITH NOCHECK
    ADD CONSTRAINT [FK_Encounter_Bed_BedID] FOREIGN KEY ([BedID]) REFERENCES [dbo].[Bed] ([BedID]);


GO
PRINT N'Creating [dbo].[Encounter].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'From IHE: An interaction between a patient and care provider(s) for the purpose of providing healthcare-related service(s). Healthcare services include health assessment. For example, outpatient visit to multiple departments, home health support (including physical therapy), inpatient hospital stay, emergency room visit, field visit (e.g., traffic accident), office visit, occupational therapy, telephone call.


    An encounter is created on Admit and remains until Discharge.

    A patient is always in a bed.   Not such thing as patient without a bed.

    A Transfer is just changing beds.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Encounter';


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
ALTER TABLE [dbo].[DeviceSession] WITH CHECK CHECK CONSTRAINT [FK_DeviceSession_Encounter_EncounterID];

ALTER TABLE [dbo].[Encounter] WITH CHECK CHECK CONSTRAINT [FK_Encounter_Patient_PatientID];

ALTER TABLE [dbo].[Encounter] WITH CHECK CHECK CONSTRAINT [FK_Encounter_Bed_BedID];


GO
PRINT N'Update complete.';


GO
