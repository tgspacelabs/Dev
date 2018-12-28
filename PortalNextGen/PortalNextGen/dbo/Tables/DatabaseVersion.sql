CREATE TABLE [dbo].[DatabaseVersion] (
    [DatabaseVersionID]       INT           IDENTITY (1, 1) NOT NULL,
    [VersionCode]             VARCHAR (30)  NOT NULL,
    [InstallDateTime]         DATETIME2 (7) NOT NULL,
    [StatusCode]              VARCHAR (30)  NULL,
    [PreInstallProgram]       VARCHAR (255) NULL,
    [PreInstallProgramFlags]  VARCHAR (30)  NULL,
    [InstallProgram]          VARCHAR (255) NULL,
    [InstallProgramFlags]     VARCHAR (30)  NULL,
    [PostInstallProgram]      VARCHAR (255) NULL,
    [PostInstallProgramFlags] VARCHAR (30)  NULL,
    [CreatedDateTime]         DATETIME2 (7) CONSTRAINT [DF_DatabaseVersion_CreateDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DatabaseVersion_DatabaseVersionID] PRIMARY KEY CLUSTERED ([DatabaseVersionID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DatabaseVersion_VersionCode]
    ON [dbo].[DatabaseVersion]([VersionCode] ASC);

