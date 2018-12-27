CREATE TYPE [dbo].[GetPatientUpdateInformationTypeX] AS TABLE (
    [DeviceId]         UNIQUEIDENTIFIER NOT NULL,
    [PatientSessionId] UNIQUEIDENTIFIER NOT NULL,
    [ID1]              NVARCHAR (30)    NOT NULL);

