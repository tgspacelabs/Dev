CREATE TABLE [dbo].[VitalLiveTemporary] (
    [VitalLiveTemporaryID] BIGINT         IDENTITY (0, 1) NOT NULL,
    [PatientID]            INT            NOT NULL,
    [OriginalPatientID]    INT            NULL,
    [MonitorID]            INT            NOT NULL,
    [CollectionDateTime]   DATETIME2 (7)  NOT NULL,
    [VitalValue]           VARCHAR (4000) NOT NULL,
    [VitalTime]            VARCHAR (3950) NOT NULL,
    [CreatedDateTime]      DATETIME2 (7)  CONSTRAINT [DF_VitalLiveTemporary_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_VitalLiveTemporary_VitalLiveTemporaryID] PRIMARY KEY CLUSTERED ([VitalLiveTemporaryID] ASC),
    CONSTRAINT [FK_VitalLiveTemporary_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_VitalLiveTemporary_CreatedDateTime]
    ON [dbo].[VitalLiveTemporary]([CreatedDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_VitalLiveTemporary_Patient_PatientID]
    ON [dbo].[VitalLiveTemporary]([PatientID] ASC);

