CREATE TABLE [dbo].[VitalLive] (
    [PatientID]          INT            NOT NULL,
    [OriginalPatientID]  INT            NULL,
    [MonitorID]          INT            NOT NULL,
    [CollectionDateTime] DATETIME2 (7)  NOT NULL,
    [VitalValue]         VARCHAR (4000) NOT NULL,
    [VitalTime]          VARCHAR (3950) NULL,
    [CreatedDateTime]    DATETIME2 (7)  CONSTRAINT [DF_VitalLive_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_VitalLive_PatientID_MonitorID_CollectionDateTime] PRIMARY KEY CLUSTERED ([PatientID] ASC, [MonitorID] ASC, [CollectionDateTime] ASC),
    CONSTRAINT [FK_VitalLive_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_VitalLive_Patient_PatientID]
    ON [dbo].[VitalLive]([PatientID] ASC);

