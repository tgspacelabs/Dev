CREATE TABLE [dbo].[MonitorLoaderDuplicateInformation] (
    [MonitorLoaderDuplicateInformationID] INT           IDENTITY (1, 1) NOT NULL,
    [OriginalID]                          VARCHAR (20)  NOT NULL,
    [DuplicateID]                         VARCHAR (20)  NOT NULL,
    [OriginalMonitor]                     VARCHAR (5)   NOT NULL,
    [DuplicateMonitor]                    VARCHAR (5)   NOT NULL,
    [InsertDateTime]                      DATETIME2 (7) CONSTRAINT [DF_MonitorLoaderDuplicateInformation_InsertDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [CreatedDateTime]                     DATETIME2 (7) CONSTRAINT [DF_MonitorLoaderDuplicateInformation_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MonitorLoaderDuplicateInformation_MonitorLoaderDuplicateInformationID] PRIMARY KEY CLUSTERED ([MonitorLoaderDuplicateInformationID] ASC)
);

