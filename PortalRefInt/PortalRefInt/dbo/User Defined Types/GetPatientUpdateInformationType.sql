CREATE TYPE [dbo].[GetPatientUpdateInformationType] AS TABLE (
    [DeviceId]         BIGINT NOT NULL,
    [PatientSessionId] BIGINT NOT NULL,
    [ID1]              VARCHAR (MAX)    NOT NULL);

