CREATE TABLE [dbo].[LogDataX] (
    [LogId]            UNIQUEIDENTIFIER NOT NULL,
    [DateTime]         DATETIME         NOT NULL,
    [PatientID]        VARCHAR (256)    NULL,
    [Application]      NVARCHAR (256)   NULL,
    [DeviceName]       NVARCHAR (256)   NULL,
    [Message]          NVARCHAR (MAX)   NOT NULL,
    [LocalizedMessage] NVARCHAR (MAX)   NULL,
    [MessageId]        INT              NULL,
    [LogType]          NVARCHAR (64)    NOT NULL
);

