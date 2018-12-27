CREATE TABLE [dbo].[DeviceInfoData] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [DeviceSessionId] UNIQUEIDENTIFIER NOT NULL,
    [Name]            NCHAR (25)       NOT NULL,
    [Value]           NCHAR (100)      NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_DeviceInfoData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE CLUSTERED INDEX [CL_DeviceInfoData_DeviceSessionId_Name_TimestampUTC]
    ON [dbo].[DeviceInfoData]([DeviceSessionId] ASC, [Name] ASC, [TimestampUTC] DESC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceInfoData_Name_DeviceSessionId_Value_TimestampUTC]
    ON [dbo].[DeviceInfoData]([Name] ASC)
    INCLUDE([DeviceSessionId], [Value], [TimestampUTC]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DeviceInfoData';

