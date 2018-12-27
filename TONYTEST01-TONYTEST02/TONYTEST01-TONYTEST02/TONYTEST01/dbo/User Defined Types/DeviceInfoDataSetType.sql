CREATE TYPE [dbo].[DeviceInfoDataSetType] AS TABLE (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (100)    NULL,
    [DeviceSessionId] UNIQUEIDENTIFIER NOT NULL,
    [TimeStampUTC]    DATETIME         NOT NULL);

