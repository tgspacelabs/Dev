CREATE TABLE [dbo].[Patient] (
    [PatientID]       INT           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Patient_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED ([PatientID] ASC)
);

