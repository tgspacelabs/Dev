
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/14/2015 09:56:30
-- Generated from EDMX file: d:\documents\visual studio 2015\Projects\WindowsFormsApplication2\WindowsFormsApplication2\PatientData.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [PatientDataX];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_PatientDevice]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Devices] DROP CONSTRAINT [FK_PatientDevice];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Patients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Patients];
GO
IF OBJECT_ID(N'[dbo].[Devices]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Devices];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Patients'
CREATE TABLE [dbo].[Patients] (
    [PatientID] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(50)  NOT NULL,
    [LastName] nvarchar(50)  NOT NULL,
    [MedicalRecordNumber] nvarchar(30)  NOT NULL,
    [Birthdate] datetime  NOT NULL
);
GO

-- Creating table 'Devices'
CREATE TABLE [dbo].[Devices] (
    [DeviceID] int IDENTITY(1,1) NOT NULL,
    [DeviceName] varchar(100)  NOT NULL,
    [Model] varchar(100)  NOT NULL,
    [Type] varchar(50)  NOT NULL,
    [PatientPatientID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [PatientID] in table 'Patients'
ALTER TABLE [dbo].[Patients]
ADD CONSTRAINT [PK_Patients]
    PRIMARY KEY CLUSTERED ([PatientID] ASC);
GO

-- Creating primary key on [DeviceID] in table 'Devices'
ALTER TABLE [dbo].[Devices]
ADD CONSTRAINT [PK_Devices]
    PRIMARY KEY CLUSTERED ([DeviceID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [PatientPatientID] in table 'Devices'
ALTER TABLE [dbo].[Devices]
ADD CONSTRAINT [FK_PatientDevice]
    FOREIGN KEY ([PatientPatientID])
    REFERENCES [dbo].[Patients]
        ([PatientID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PatientDevice'
CREATE INDEX [IX_FK_PatientDevice]
ON [dbo].[Devices]
    ([PatientPatientID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------