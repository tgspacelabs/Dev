CREATE TABLE [dbo].[ValuePatient] (
    [ValuePatientID]        INT             IDENTITY (1, 1) NOT NULL,
    [PatientID]             INT             NOT NULL,
    [TypeCode]              VARCHAR (25)    NOT NULL,
    [ConfigurationName]     VARCHAR (40)    NOT NULL,
    [ConfigurationValue]    NVARCHAR (1800) NULL,
    [ConfigurationXmlValue] XML             NULL,
    [ValueType]             VARCHAR (20)    NOT NULL,
    [Timestamp]             DATETIME2 (7)   CONSTRAINT [DF_ValuePatient_Timestamp] DEFAULT (sysutcdatetime()) NOT NULL,
    [CreatedDateTime]       DATETIME2 (7)   CONSTRAINT [DF_ValuePatient_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ValuePatient_ValuePatientID] PRIMARY KEY CLUSTERED ([ValuePatientID] ASC),
    CONSTRAINT [FK_ValuePatient_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_ValuePatient_PatientID_TypeCode_ConfigurationName]
    ON [dbo].[ValuePatient]([PatientID] ASC, [TypeCode] ASC, [ConfigurationName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ValuePatient_Timestamp_PatientID_TypeCode_ConfigurationName]
    ON [dbo].[ValuePatient]([Timestamp] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ValuePatient_Patient_PatientID]
    ON [dbo].[ValuePatient]([PatientID] ASC);

