CREATE TABLE [dbo].[PatientImage] (
    [PatientImageID]    INT             IDENTITY (1, 1) NOT NULL,
    [PatientID]         INT             NOT NULL,
    [OrderID]           INT             NOT NULL,
    [SequenceNumber]    SMALLINT        NOT NULL,
    [OriginalPatientID] INT             NOT NULL,
    [ImageTypeCodeID]   INT             NOT NULL,
    [ImagePath]         NVARCHAR (255)  NOT NULL,
    [Image]             VARBINARY (MAX) NOT NULL,
    [CreatedDateTime]   DATETIME2 (7)   CONSTRAINT [DF_PatientImage_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientImage_PatientImageID] PRIMARY KEY CLUSTERED ([PatientImageID] ASC),
    CONSTRAINT [FK_patient_image_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientImage_PatientID_OrderID_SequenceNumber]
    ON [dbo].[PatientImage]([PatientID] ASC, [OrderID] ASC, [SequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_patient_image_Patient_PatientID]
    ON [dbo].[PatientImage]([PatientID] ASC);

