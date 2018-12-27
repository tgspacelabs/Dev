CREATE TYPE [dbo].[DeviceSessionDataType] AS TABLE (
    [Id]               BIGINT NULL,
    [DeviceId]         BIGINT NULL,
    [UniqueDeviceName] VARCHAR (50)     NULL,
    [BeginTimeUTC]     DATETIME         NULL,
    [EndTimeUTC]       DATETIME         NULL);

