CREATE TYPE [dbo].[TopicSessionDataType] AS TABLE (
    [Id]               BIGINT NULL,
    [TopicTypeId]      BIGINT NULL,
    [TopicInstanceId]  BIGINT NULL,
    [DeviceSessionId]  BIGINT NULL,
    [PatientSessionId] BIGINT NULL,
    [BeginTimeUTC]     DATETIME         NULL,
    [EndTimeUTC]       DATETIME         NULL);

