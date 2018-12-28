CREATE TABLE [dbo].[DeviceInformation] (
    [DeviceInformationID] INT            IDENTITY (1, 1) NOT NULL,
    [DeviceSessionID]     INT            NOT NULL,
    [Name]                NVARCHAR (25)  NOT NULL,
    [Value]               NVARCHAR (100) NOT NULL,
    [DateTimeStamp]       DATETIME2 (7)  NOT NULL,
    [CreatedDateTime]     DATETIME2 (7)  CONSTRAINT [DF_DeviceInformation_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DeviceInformation_DeviceInformationID] PRIMARY KEY CLUSTERED ([DeviceInformationID] ASC),
    CONSTRAINT [FK_DeviceInformation_DeviceSession__DeviceSessionID] FOREIGN KEY ([DeviceSessionID]) REFERENCES [dbo].[DeviceSession] ([DeviceSessionID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DeviceInformation_DeviceSessionID_Name_TimestampUTC_DeviceInformationID_Value]
    ON [dbo].[DeviceInformation]([DeviceSessionID] ASC, [Name] ASC, [DateTimeStamp] DESC, [DeviceInformationID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DeviceInformation_DeviceSessionID_Name_DateTimeStamp]
    ON [dbo].[DeviceInformation]([DeviceSessionID] ASC, [Name] ASC, [DateTimeStamp] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInformation_Name_DeviceSessionId_Value_DateTimeStamp]
    ON [dbo].[DeviceInformation]([Name] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DeviceInformation_DeviceSession__DeviceSessionID]
    ON [dbo].[DeviceInformation]([DeviceSessionID] ASC);

