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
PRINT N'Move Schema refactoring operation with key 064bfce4-02ed-4388-b23f-4e6ee13cf777 is skipped, model element [dbo].[PatientX] is not found in target database.';


GO
PRINT N'Rename refactoring operation with key f3be9214-f15e-49ff-8a66-8c0c459ad078 is skipped, element [PHI].[PatientX] (SqlTable) will not be renamed to [Patient]';


GO
PRINT N'Dropping unnamed constraint on [dbo].[Gender]...';


GO
ALTER TABLE [dbo].[Gender] DROP CONSTRAINT [DF__Gender__GenderNa__32E0915F];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Gender]...';


GO
ALTER TABLE [dbo].[Gender] DROP CONSTRAINT [DF__Gender__CreatedD__33D4B598];


GO
PRINT N'Dropping [dbo].[DF_Patient_DateOfBirth]...';


GO
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [DF_Patient_DateOfBirth];


GO
PRINT N'Dropping [dbo].[DF_Patient_SocialSecurityNumber]...';


GO
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [DF_Patient_SocialSecurityNumber];


GO
PRINT N'Dropping [dbo].[RefDevice4]...';


GO
ALTER TABLE [dbo].[DeviceParameter] DROP CONSTRAINT [RefDevice4];


GO
PRINT N'Dropping [dbo].[RefParameter5]...';


GO
ALTER TABLE [dbo].[DeviceParameter] DROP CONSTRAINT [RefParameter5];


GO
PRINT N'Dropping [dbo].[RefParameter6]...';


GO
ALTER TABLE [dbo].[ParameterValue] DROP CONSTRAINT [RefParameter6];


GO
PRINT N'Dropping [dbo].[RefParameter7]...';


GO
ALTER TABLE [dbo].[ParameterValue] DROP CONSTRAINT [RefParameter7];


GO
PRINT N'Dropping [dbo].[PK5]...';


GO
ALTER TABLE [dbo].[DeviceParameter] DROP CONSTRAINT [PK5];


GO
PRINT N'Dropping [dbo].[PK10]...';


GO
ALTER TABLE [dbo].[Gender] DROP CONSTRAINT [PK10];


GO
PRINT N'Dropping [dbo].[PK4]...';


GO
ALTER TABLE [dbo].[Parameter] DROP CONSTRAINT [PK4];


GO
/*
The column [dbo].[Gender].[GenderName] is being dropped, data loss could occur.
*/
GO
PRINT N'Starting rebuilding table [dbo].[Gender]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Gender] (
    [GenderID]        TINYINT       IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (50)  DEFAULT ('') NOT NULL,
    [CreatedDateTime] DATETIME2 (7) DEFAULT (SYSUTCDATETIME()) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Gender_GenderID1] PRIMARY KEY CLUSTERED ([GenderID] ASC) WITH (FILLFACTOR = 100)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Gender])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Gender] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Gender] ([GenderID], [CreatedDateTime])
        SELECT   [GenderID],
                 [CreatedDateTime]
        FROM     [dbo].[Gender]
        ORDER BY [GenderID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Gender] OFF;
    END

DROP TABLE [dbo].[Gender];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Gender]', N'Gender';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Gender_GenderID1]', N'PK_Gender_GenderID', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Altering [dbo].[Patient]...';


GO
ALTER TABLE [dbo].[Patient] DROP COLUMN [DateOfBirth], COLUMN [FirstName], COLUMN [LastName], COLUMN [SocialSecurityNumber];


GO
PRINT N'Creating [PHI].[Patient]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [PHI].[Patient] (
    [PatientID]            INT           NOT NULL,
    [FirstName]            NVARCHAR (50) NOT NULL,
    [LastName]             NVARCHAR (50) NOT NULL,
    [DateOfBirth]          DATE          NOT NULL,
    [SocialSecurityNumber] VARCHAR (12)  NOT NULL,
    PRIMARY KEY CLUSTERED ([PatientID] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[PK5]...';


GO
ALTER TABLE [dbo].[DeviceParameter]
    ADD CONSTRAINT [PK5] PRIMARY KEY CLUSTERED ([DeviceParameterID] ASC, [DeviceID] ASC, [ParameterID] ASC) WITH (FILLFACTOR = 100);


GO
PRINT N'Creating [dbo].[PK_Parameter_ParameterID]...';


GO
ALTER TABLE [dbo].[Parameter]
    ADD CONSTRAINT [PK_Parameter_ParameterID] PRIMARY KEY CLUSTERED ([ParameterID] ASC) WITH (FILLFACTOR = 100);


GO
PRINT N'Creating [PHI].[DF_Patient_DateOfBirth]...';


GO
ALTER TABLE [PHI].[Patient]
    ADD CONSTRAINT [DF_Patient_DateOfBirth] DEFAULT ('1800-01-01') FOR [DateOfBirth];


GO
PRINT N'Creating [PHI].[DF_Patient_SocialSecurityNumber]...';


GO
ALTER TABLE [PHI].[Patient]
    ADD CONSTRAINT [DF_Patient_SocialSecurityNumber] DEFAULT ('') FOR [SocialSecurityNumber];


GO
PRINT N'Creating [dbo].[RefParameter6]...';


GO
ALTER TABLE [dbo].[ParameterValue] WITH NOCHECK
    ADD CONSTRAINT [RefParameter6] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
PRINT N'Creating [dbo].[RefParameter7]...';


GO
ALTER TABLE [dbo].[ParameterValue] WITH NOCHECK
    ADD CONSTRAINT [RefParameter7] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
PRINT N'Creating [dbo].[FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID]...';


GO
ALTER TABLE [dbo].[DeviceParameter] WITH NOCHECK
    ADD CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([DeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID]);


GO
PRINT N'Creating [dbo].[FK_DeviceParameter_Parameter_ParameterID]...';


GO
ALTER TABLE [dbo].[DeviceParameter] WITH NOCHECK
    ADD CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '064bfce4-02ed-4388-b23f-4e6ee13cf777')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('064bfce4-02ed-4388-b23f-4e6ee13cf777')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f3be9214-f15e-49ff-8a66-8c0c459ad078')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f3be9214-f15e-49ff-8a66-8c0c459ad078')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[ParameterValue] WITH CHECK CHECK CONSTRAINT [RefParameter6];

ALTER TABLE [dbo].[ParameterValue] WITH CHECK CHECK CONSTRAINT [RefParameter7];

ALTER TABLE [dbo].[DeviceParameter] WITH CHECK CHECK CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID];

ALTER TABLE [dbo].[DeviceParameter] WITH CHECK CHECK CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID];


GO
PRINT N'Update complete.';


GO