CREATE TABLE [dbo].[SavedEventVital] (
    [SavedEventVitalID]    INT            IDENTITY (1, 1) NOT NULL,
    [PatientID]            INT            NOT NULL,
    [EventID]              BIGINT         NOT NULL,
    [GlobalDataSystemCode] NVARCHAR (80)  NOT NULL,
    [ResultDateTime]       DATETIME2 (7)  NULL,
    [ResultValue]          NVARCHAR (200) NULL,
    [CreatedDateTime]      DATETIME2 (7)  CONSTRAINT [DF_SavedEventVital_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SavedEventVital_SavedEventVitalID] PRIMARY KEY CLUSTERED ([SavedEventVitalID] ASC),
    CONSTRAINT [FK_SavedEventVital_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_SavedEventVital_PatientSavedEvent_PatientID_EventID] FOREIGN KEY ([PatientID], [EventID]) REFERENCES [dbo].[PatientSavedEvent] ([PatientID], [EventID])
);


GO
CREATE NONCLUSTERED INDEX [IX_SavedEventVital_PatientID_EventID_GlobalDataSystemCode]
    ON [dbo].[SavedEventVital]([PatientID] ASC, [EventID] ASC, [GlobalDataSystemCode] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventVital_Patient_PatientID]
    ON [dbo].[SavedEventVital]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventVital_PatientSavedEvent_PatientID_EventID]
    ON [dbo].[SavedEventVital]([PatientID] ASC, [EventID] ASC);

