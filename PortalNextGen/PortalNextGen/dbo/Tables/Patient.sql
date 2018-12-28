CREATE TABLE [dbo].[Patient] (
    [PatientID]       INT           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Patient_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Patient_PatientID] PRIMARY KEY CLUSTERED ([PatientID] ASC),
    CONSTRAINT [FK_Patient_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Patient_Patient_PatientID]
    ON [dbo].[Patient]([PatientID] ASC);

