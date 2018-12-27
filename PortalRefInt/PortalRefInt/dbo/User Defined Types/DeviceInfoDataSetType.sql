CREATE TYPE [dbo].[DeviceInfoDataSetType] AS TABLE (
    [Id]              BIGINT NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (100)    NULL,
    [DeviceSessionId] BIGINT NOT NULL,
    [TimestampUTC]    DATETIME         NOT NULL);

