CREATE TABLE [dbo].[Patient] (
    [PatientID]  INT          IDENTITY (1, 1) NOT NULL,
    [NonPhiData] VARCHAR (30) NULL,
    CONSTRAINT [PK_Patient_PatientID] PRIMARY KEY CLUSTERED ([PatientID] ASC)
);

