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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS OFF,
                ANSI_PADDING OFF,
                ANSI_WARNINGS OFF,
                ARITHABORT OFF,
                CONCAT_NULL_YIELDS_NULL OFF,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER OFF,
                ANSI_NULL_DEFAULT OFF,
                CURSOR_DEFAULT GLOBAL,
                RECOVERY SIMPLE,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY CHECKSUM,
                DATE_CORRELATION_OPTIMIZATION OFF,
                ENABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
PRINT N'Creating [PHI]...';


GO
CREATE SCHEMA [PHI]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [PHI].[Patient]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [PHI].[Patient] (
    [PatientID]            BIGINT        NOT NULL,
    [FirstName]            NVARCHAR (50) NOT NULL,
    [LastName]             NVARCHAR (50) NOT NULL,
    [DateOfBirth]          DATE          NOT NULL,
    [SocialSecurityNumber] VARCHAR (12)  NOT NULL,
    [GenderID]             TINYINT       NOT NULL,
    PRIMARY KEY CLUSTERED ([PatientID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[AcquistionModule]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[AcquistionModule] (
    [AcquistionModuleID] INT           NOT NULL,
    [MonitoringDeviceID] BIGINT        NOT NULL,
    [CreatedDateTime]    DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_AcquistionModule_AcquistionModuleID] PRIMARY KEY CLUSTERED ([AcquistionModuleID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Bed]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Bed] (
    [BedID]           INT           IDENTITY (1, 1) NOT NULL,
    [RoomID]          INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Bed_BedID] PRIMARY KEY CLUSTERED ([BedID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[DeviceParameter]...';


GO
CREATE TABLE [dbo].[DeviceParameter] (
    [DeviceParameterID] BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [DeviceID]          BIGINT        NOT NULL,
    [ParameterID]       BIGINT        NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK5] PRIMARY KEY CLUSTERED ([DeviceParameterID] ASC, [DeviceID] ASC, [ParameterID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[DeviceSession]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[DeviceSession] (
    [DeviceSessionID]    BIGINT        NOT NULL,
    [MonitoringDeviceID] BIGINT        NOT NULL,
    [EncounterID]        INT           NOT NULL,
    [BeginDateTime]      DATETIME2 (7) NOT NULL,
    [EndDateTime]        DATETIME2 (7) NULL,
    [CreatedDateTime]    DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_DeviceSession_DeviceSessionID] PRIMARY KEY CLUSTERED ([DeviceSessionID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Encounter]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Encounter] (
    [EncounterID]     INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]       BIGINT        NOT NULL,
    [BeginDateTime]   DATETIME2 (7) NOT NULL,
    [EndDateTime]     DATETIME2 (7) NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Encounter_EncounterID] PRIMARY KEY CLUSTERED ([EncounterID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Event]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Event] (
    [EventID]   INT       NOT NULL,
    [Timestamp] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Event_EventID] PRIMARY KEY CLUSTERED ([EventID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Facility]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Facility] (
    [FacilityID]      INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]  INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Facility_FacilityID] PRIMARY KEY CLUSTERED ([FacilityID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Gender]...';


GO
CREATE TABLE [dbo].[Gender] (
    [GenderID]        TINYINT       IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Gender_GenderID] PRIMARY KEY CLUSTERED ([GenderID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[MonitoringDevice]...';


GO
CREATE TABLE [dbo].[MonitoringDevice] (
    [MonitoringDeviceID] BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [Name]               VARCHAR (255) NULL,
    [CreatedDateTime]    DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_MonitoringDevice_MonitoringDeviceID] PRIMARY KEY CLUSTERED ([MonitoringDeviceID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[Organization]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Organization] (
    [OrganizationID]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Organization_OrganizationID] PRIMARY KEY CLUSTERED ([OrganizationID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Parameter]...';


GO
CREATE TABLE [dbo].[Parameter] (
    [ParameterID]     BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [ParameterName]   VARCHAR (255) NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Parameter_ParameterID] PRIMARY KEY CLUSTERED ([ParameterID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[ParameterType]...';


GO
CREATE TABLE [dbo].[ParameterType] (
    [ParameterTypeID]   BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [ParameterTypeName] VARCHAR (50)  NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK9] PRIMARY KEY NONCLUSTERED ([ParameterTypeID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[ParameterValue]...';


GO
CREATE TABLE [dbo].[ParameterValue] (
    [ParameterValueID] BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [ParameterID]      BIGINT        NOT NULL,
    [Value]            SQL_VARIANT   NOT NULL,
    [CreatedDateTime]  DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK6] PRIMARY KEY NONCLUSTERED ([ParameterID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[Patient]...';


GO
CREATE TABLE [dbo].[Patient] (
    [PatientID]       BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Patient_PatientID] PRIMARY KEY CLUSTERED ([PatientID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[PatientDevice]...';


GO
CREATE TABLE [dbo].[PatientDevice] (
    [PatientDeviceID] BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [PatientID]       BIGINT        NOT NULL,
    [DeviceID]        BIGINT        NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK3] PRIMARY KEY NONCLUSTERED ([PatientDeviceID] ASC, [PatientID] ASC, [DeviceID] ASC) WITH (FILLFACTOR = 100)
);


GO
PRINT N'Creating [dbo].[Room]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Room] (
    [RoomID]          INT           IDENTITY (1, 1) NOT NULL,
    [UnitID]          INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Room_RoomID] PRIMARY KEY CLUSTERED ([RoomID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Unit]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[Unit] (
    [UnitID]          INT           IDENTITY (1, 1) NOT NULL,
    [FacilityID]      INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([UnitID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [PHI].[DF_Patient_DateOfBirth]...';


GO
ALTER TABLE [PHI].[Patient]
    ADD CONSTRAINT [DF_Patient_DateOfBirth] DEFAULT ('1000-01-01') FOR [DateOfBirth];


GO
PRINT N'Creating [PHI].[DF_Patient_SocialSecurityNumber]...';


GO
ALTER TABLE [PHI].[Patient]
    ADD CONSTRAINT [DF_Patient_SocialSecurityNumber] DEFAULT ('') FOR [SocialSecurityNumber];


GO
PRINT N'Creating unnamed constraint on [dbo].[AcquistionModule]...';


GO
ALTER TABLE [dbo].[AcquistionModule]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_Bed_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Bed]
    ADD CONSTRAINT [DF_Bed_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[DeviceParameter]...';


GO
ALTER TABLE [dbo].[DeviceParameter]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_DeviceSession_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[DeviceSession]
    ADD CONSTRAINT [DF_DeviceSession_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_Encounter_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Encounter]
    ADD CONSTRAINT [DF_Encounter_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_Facility_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Facility]
    ADD CONSTRAINT [DF_Facility_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[Gender]...';


GO
ALTER TABLE [dbo].[Gender]
    ADD DEFAULT ('') FOR [Name];


GO
PRINT N'Creating unnamed constraint on [dbo].[Gender]...';


GO
ALTER TABLE [dbo].[Gender]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[MonitoringDevice]...';


GO
ALTER TABLE [dbo].[MonitoringDevice]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_Organization_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Organization]
    ADD CONSTRAINT [DF_Organization_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[Parameter]...';


GO
ALTER TABLE [dbo].[Parameter]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[ParameterType]...';


GO
ALTER TABLE [dbo].[ParameterType]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[ParameterValue]...';


GO
ALTER TABLE [dbo].[ParameterValue]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[Patient]...';


GO
ALTER TABLE [dbo].[Patient]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[PatientDevice]...';


GO
ALTER TABLE [dbo].[PatientDevice]
    ADD DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_Room_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Room]
    ADD CONSTRAINT [DF_Room_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [dbo].[DF_Unit_CreatedDateTime]...';


GO
ALTER TABLE [dbo].[Unit]
    ADD CONSTRAINT [DF_Unit_CreatedDateTime] DEFAULT (SYSUTCDATETIME()) FOR [CreatedDateTime];


GO
PRINT N'Creating [PHI].[FK_Patient_Patient_PatientID]...';


GO
ALTER TABLE [PHI].[Patient]
    ADD CONSTRAINT [FK_Patient_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]);


GO
PRINT N'Creating [dbo].[FK_AcquistionModule_MonitoringDevice_MonitoringDeviceID]...';


GO
ALTER TABLE [dbo].[AcquistionModule]
    ADD CONSTRAINT [FK_AcquistionModule_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([MonitoringDeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID]);


GO
PRINT N'Creating [dbo].[FK_Bed_Room_RoomID]...';


GO
ALTER TABLE [dbo].[Bed]
    ADD CONSTRAINT [FK_Bed_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [dbo].[Room] ([RoomID]);


GO
PRINT N'Creating [dbo].[FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID]...';


GO
ALTER TABLE [dbo].[DeviceParameter]
    ADD CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([DeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID]);


GO
PRINT N'Creating [dbo].[FK_DeviceParameter_Parameter_ParameterID]...';


GO
ALTER TABLE [dbo].[DeviceParameter]
    ADD CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
PRINT N'Creating [dbo].[FK_DeviceSession_Encounter_EncounterID]...';


GO
ALTER TABLE [dbo].[DeviceSession]
    ADD CONSTRAINT [FK_DeviceSession_Encounter_EncounterID] FOREIGN KEY ([EncounterID]) REFERENCES [dbo].[Encounter] ([EncounterID]);


GO
PRINT N'Creating [dbo].[FK_Encounter_Patient_PatientID]...';


GO
ALTER TABLE [dbo].[Encounter]
    ADD CONSTRAINT [FK_Encounter_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]);


GO
PRINT N'Creating [dbo].[FK_Facility_Organization_OrganizationID]...';


GO
ALTER TABLE [dbo].[Facility]
    ADD CONSTRAINT [FK_Facility_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID]);


GO
PRINT N'Creating [dbo].[RefParameter6]...';


GO
ALTER TABLE [dbo].[ParameterValue]
    ADD CONSTRAINT [RefParameter6] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
PRINT N'Creating [dbo].[RefParameter7]...';


GO
ALTER TABLE [dbo].[ParameterValue]
    ADD CONSTRAINT [RefParameter7] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
PRINT N'Creating [dbo].[RefDevice3]...';


GO
ALTER TABLE [dbo].[PatientDevice]
    ADD CONSTRAINT [RefDevice3] FOREIGN KEY ([DeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID]);


GO
PRINT N'Creating [dbo].[RefPatient2]...';


GO
ALTER TABLE [dbo].[PatientDevice]
    ADD CONSTRAINT [RefPatient2] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]);


GO
PRINT N'Creating [dbo].[FK_Room_Unit_UnitID]...';


GO
ALTER TABLE [dbo].[Room]
    ADD CONSTRAINT [FK_Room_Unit_UnitID] FOREIGN KEY ([UnitID]) REFERENCES [dbo].[Unit] ([UnitID]);


GO
PRINT N'Creating [dbo].[FK_Unit_Facility_FacilityID]...';


GO
ALTER TABLE [dbo].[Unit]
    ADD CONSTRAINT [FK_Unit_Facility_FacilityID] FOREIGN KEY ([FacilityID]) REFERENCES [dbo].[Facility] ([FacilityID]);


GO
PRINT N'Creating [dbo].[DeviceSession].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A period of monitoring by a device.

    There is always an active session on a device.

    The session may or may not have a patient associated (Encounter) with it.  An anonymous session is a session with no associated patient. 

    When a patient is associated with device a new session is created (and the previous one ended)

    When a patient is dis-associated the active session is ended and new one created with no associated patient.

    The Clinical Mgmt Web App can be used to reconcile sessions with patients. For example it was known that a anonymous session actually had John Doe associated with it then it can be retroactively associated with John Doe.    Sessions can be split and merged to retroactively  fix up inconsistencies with P2DA.  
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DeviceSession';


GO
PRINT N'Creating [dbo].[Encounter].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'From IHE: An interaction between a patient and care provider(s) for the purpose of providing healthcare-related service(s). Healthcare services include health assessment. For example, outpatient visit to multiple departments, home health support (including physical therapy), inpatient hospital stay, emergency room visit, field visit (e.g., traffic accident), office visit, occupational therapy, telephone call.


    An encounter is created on Admit and remains until Discharge.

    A patient is always in a bed.   Not such thing as patient without a bed.

    A Transfer is just changing beds.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Encounter';


GO
PRINT N'Creating [dbo].[Event].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'All events are formally defined.  They don''t leave it up to individual clients to infer an event from various property changes.  Examples of events

    Admit, Discharge,Transfer , P2DAssociate, P2DDisassocate

Events are what is stored for retrospective data - think an event log as  stream of events.    Devices, Patients, and Org''s will have event logs.

OPEN issue:  How to get the current state of object (eg Alarm) from a event log.  
1) either capture entire state of object with every event (storage/net bloat?) or 
2) Send periodic checkpoints  then the current state can be reconstructed by apply deltas to last checkpoint.   
Option 1 may constrain the logical design of an object (implementation details on property size''s) ,  Option 2 is extra coding someplace.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Event';


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '064bfce4-02ed-4388-b23f-4e6ee13cf777')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('064bfce4-02ed-4388-b23f-4e6ee13cf777')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f3be9214-f15e-49ff-8a66-8c0c459ad078')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f3be9214-f15e-49ff-8a66-8c0c459ad078')

GO

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
        [GenderID] TINYINT IDENTITY(1, 1) NOT NULL,
        [Name]     VARCHAR(50)
            DEFAULT ('') NOT NULL,
    );
GO

INSERT INTO [#Gender]
    (
        [Name]
    )
VALUES
    (
        'Male' -- Name - varchar(50)
    );
GO

INSERT INTO [#Gender]
    (
        [Name]
    )
VALUES
    (
        'Female' -- Name - varchar(50)
    );
GO

INSERT INTO [#Gender]
    (
        [Name]
    )
VALUES
    (
        'Other' -- Name - varchar(50)
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
                [#Gender] AS [g];
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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO