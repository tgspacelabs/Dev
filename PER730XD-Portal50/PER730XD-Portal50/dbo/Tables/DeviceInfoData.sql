CREATE TABLE [dbo].[DeviceInfoData] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [DeviceSessionId] UNIQUEIDENTIFIER NOT NULL,
    [Name]            NVARCHAR (25)    NOT NULL,
    [Value]           NVARCHAR (100)   NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [Sequence]        INT              IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_DeviceInfoData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_Name_DeviceSessionId_Value_TimestampUTC]
    ON [dbo].[DeviceInfoData]([Name] ASC)
    INCLUDE([DeviceSessionId], [Value], [TimestampUTC]);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_DeviceSessionId_Name_TimestampUTC_Value]
    ON [dbo].[DeviceInfoData]([DeviceSessionId] ASC, [Name] ASC, [TimestampUTC] DESC)
    INCLUDE([Value]);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_Name_DeviceSessionId_TimestampUTC_Value]
    ON [dbo].[DeviceInfoData]([Name] ASC, [DeviceSessionId] ASC, [TimestampUTC] DESC)
    INCLUDE([Value]);

