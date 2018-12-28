CREATE TABLE [dbo].[PatientSessionMap] (
    [PatientSessionMapID] INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]           INT           NOT NULL,
    [PatientSessionID]    INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_PatientSessionMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientSessionMap_PatientID_PatientSessionMapID] PRIMARY KEY CLUSTERED ([PatientSessionMapID] DESC, [PatientID] ASC),
    CONSTRAINT [FK_PatientSessionMap_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_PatientSessionMap_PatientSession_PatientSessionID] FOREIGN KEY ([PatientSessionID]) REFERENCES [dbo].[PatientSession] ([PatientSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessionMap_PatientID_PatientSessionID]
    ON [dbo].[PatientSessionMap]([PatientID] ASC, [PatientSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessionMap_PatientSessionID_PatientSessionMapID]
    ON [dbo].[PatientSessionMap]([PatientSessionID] ASC, [PatientSessionMapID] DESC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientSessionMap_Patient_PatientID]
    ON [dbo].[PatientSessionMap]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientSessionMap_PatientSession_PatientSessionID]
    ON [dbo].[PatientSessionMap]([PatientSessionID] ASC);

