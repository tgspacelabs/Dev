CREATE TABLE [dbo].[DeviceInfoData] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [DeviceSessionId] UNIQUEIDENTIFIER NOT NULL,
    [Name]            NCHAR (25)       NOT NULL,
    [Value]           NCHAR (100)      NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_DeviceInfoData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [CL_DeviceInfoData_DeviceSessionId_Name_TimestampUTC]
    ON [dbo].[DeviceInfoData]([DeviceSessionId] ASC, [Name] ASC, [TimestampUTC] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_Name_DeviceSessionId_Value_TimestampUTC]
    ON [dbo].[DeviceInfoData]([Name] ASC)
    INCLUDE([DeviceSessionId], [Value], [TimestampUTC]);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_Name_DeviceSessionId_TimestampUTC_Value]
    ON [dbo].[DeviceInfoData]([Name] ASC, [DeviceSessionId] ASC, [TimestampUTC] DESC)
    INCLUDE([Value]);

