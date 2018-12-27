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
PRINT N'Dropping [PHI].[DF_Patient_DateOfBirth]...';


GO
ALTER TABLE [PHI].[Patient] DROP CONSTRAINT [DF_Patient_DateOfBirth];


GO
PRINT N'Dropping [PHI].[DF_Patient_SocialSecurityNumber]...';


GO
ALTER TABLE [PHI].[Patient] DROP CONSTRAINT [DF_Patient_SocialSecurityNumber];


GO
PRINT N'Starting rebuilding table [PHI].[Patient]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [PHI].[tmp_ms_xx_Patient] (
    [PatientID]            BIGINT        NOT NULL,
    [FirstName]            NVARCHAR (50) NOT NULL,
    [LastName]             NVARCHAR (50) NOT NULL,
    [DateOfBirth]          DATE          CONSTRAINT [DF_Patient_DateOfBirth] DEFAULT ('1800-01-01') NOT NULL,
    [SocialSecurityNumber] VARCHAR (12)  CONSTRAINT [DF_Patient_SocialSecurityNumber] DEFAULT ('') NOT NULL,
    PRIMARY KEY CLUSTERED ([PatientID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [PHI].[Patient])
    BEGIN
        INSERT INTO [PHI].[tmp_ms_xx_Patient] ([PatientID], [FirstName], [LastName], [DateOfBirth], [SocialSecurityNumber])
        SELECT   [PatientID],
                 [FirstName],
                 [LastName],
                 [DateOfBirth],
                 [SocialSecurityNumber]
        FROM     [PHI].[Patient]
        ORDER BY [PatientID] ASC;
    END

DROP TABLE [PHI].[Patient];

EXECUTE sp_rename N'[PHI].[tmp_ms_xx_Patient]', N'Patient';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [PHI].[FK_Patient_Patient_PatientID]...';


GO
ALTER TABLE [PHI].[Patient] WITH NOCHECK
    ADD CONSTRAINT [FK_Patient_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [PHI].[Patient] WITH CHECK CHECK CONSTRAINT [FK_Patient_Patient_PatientID];


GO
PRINT N'Update complete.';


GO