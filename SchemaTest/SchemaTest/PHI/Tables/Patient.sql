CREATE TABLE [PHI].[Patient] (
    [PatientID] INT          IDENTITY (1, 1) NOT NULL,
    [PhiData]   VARCHAR (30) NULL,
    CONSTRAINT [PK_PHI_Patient_PatientID] PRIMARY KEY CLUSTERED ([PatientID] ASC)
);

