CREATE TABLE [dbo].[WaveformLive] (
    [WaveformLiveID]    BIGINT          IDENTITY (0, 1) NOT NULL,
    [PatientID]         INT             NOT NULL,
    [OriginalPatientID] INT             NULL,
    [PatientChannelID]  INT             NOT NULL,
    [StartDateTime]     DATETIME2 (7)   NOT NULL,
    [EndDateTime]       DATETIME2 (7)   NULL,
    [CompressMethod]    CHAR (8)        NULL,
    [WaveformData]      VARBINARY (MAX) NOT NULL,
    [CreatedDateTime]   DATETIME2 (7)   CONSTRAINT [DF_WaveformLive_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_WaveformLive_WaveformLiveID] PRIMARY KEY CLUSTERED ([WaveformLiveID] ASC),
    CONSTRAINT [FK_WaveformLive_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_WaveformLive_PatientChannel_PatientChannelID] FOREIGN KEY ([PatientChannelID]) REFERENCES [dbo].[PatientChannel] ([PatientChannelID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_WaveformLive_PatientID_PatientChannelID]
    ON [dbo].[WaveformLive]([PatientID] ASC, [PatientChannelID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_WaveformLive_Patient_PatientID]
    ON [dbo].[WaveformLive]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_WaveformLive_PatientChannel_PatientChannelID]
    ON [dbo].[WaveformLive]([PatientChannelID] ASC);

