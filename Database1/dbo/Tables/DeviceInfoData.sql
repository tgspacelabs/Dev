CREATE TABLE [dbo].[DeviceInfoData] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [DeviceSessionId] UNIQUEIDENTIFIER NOT NULL,
    [Name]            NCHAR (25)       NOT NULL,
    [Value]           NCHAR (100)      NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_DeviceInfoData_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_Name_DeviceSessionId_TimestampUTC_Value]
    ON [dbo].[DeviceInfoData]([Name] ASC, [DeviceSessionId] ASC, [TimestampUTC] DESC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DeviceInfoData';

