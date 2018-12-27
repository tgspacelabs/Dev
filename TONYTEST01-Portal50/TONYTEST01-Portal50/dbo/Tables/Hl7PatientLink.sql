CREATE TABLE [dbo].[Hl7PatientLink] (
    [MessageNo]          INT              NOT NULL,
    [PatientMrn]         NVARCHAR (20)    NOT NULL,
    [PatientVisitNumber] NVARCHAR (20)    NOT NULL,
    [PatientId]          UNIQUEIDENTIFIER NULL,
    FOREIGN KEY ([MessageNo]) REFERENCES [dbo].[Hl7InboundMessage] ([MessageNo])
);

