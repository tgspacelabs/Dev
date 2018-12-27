CREATE TYPE [dbo].[PatientSessionDataType] AS TABLE (
    [Id]           BIGINT NULL,
    [BeginTimeUTC] DATETIME         NULL,
    [EndTimeUTC]   DATETIME         NULL);

