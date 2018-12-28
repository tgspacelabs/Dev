CREATE TABLE [dbo].[PatientListLink] (
    [PatientListLinkID] INT           IDENTITY (1, 1) NOT NULL,
    [MasterOwnerID]     INT           NOT NULL,
    [TransferOwnerID]   INT           NOT NULL,
    [PatientID]         INT           NULL,
    [StartDateTime]     DATETIME2 (7) NOT NULL,
    [EndDateTime]       DATETIME2 (7) NULL,
    [TypeCode]          CHAR (1)      NOT NULL,
    [Deleted]           TINYINT       NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_PatientListLink_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientListLink_PatientListLinkID] PRIMARY KEY CLUSTERED ([PatientListLinkID] ASC),
    CONSTRAINT [FK_PatientListLink_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientListLink_MasterOwnerID_TransferOwnerID_PatientID]
    ON [dbo].[PatientListLink]([MasterOwnerID] ASC, [TransferOwnerID] ASC, [PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientListLink_Patient_PatientID]
    ON [dbo].[PatientListLink]([PatientID] ASC);

