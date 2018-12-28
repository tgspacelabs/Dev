CREATE TABLE [dbo].[MonitorRequest] (
    [MonitorRequestID] INT            IDENTITY (1, 1) NOT NULL,
    [MonitorID]        INT            NOT NULL,
    [RequestType]      NVARCHAR (10)  NOT NULL,
    [RequestArguments] NVARCHAR (100) NULL,
    [Status]           NCHAR (2)      NULL,
    [ModifiedDateTime] DATETIME2 (7)  CONSTRAINT [DF_MonitorRequest_ModifiedDateTime] DEFAULT (getutcdate()) NOT NULL,
    [CreatedDateTime]  DATETIME2 (7)  CONSTRAINT [DF_MonitorRequest_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MonitorRequest_MonitorRequestID] PRIMARY KEY CLUSTERED ([MonitorRequestID] ASC)
);

