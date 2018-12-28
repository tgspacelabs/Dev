CREATE TABLE [dbo].[ParameterTimeTag] (
    [ParameterTimeTagID] INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]          INT           NOT NULL,
    [OriginalPatientID]  INT           NULL,
    [PatientChannelID]   INT           NOT NULL,
    [TimeTagType]        INT           NOT NULL,
    [ParamDateTime]      DATETIME2 (7) NOT NULL,
    [Value1]             INT           NULL,
    [Value2]             INT           NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_ParameterTimeTag_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ParameterTimeTag_ParameterTimeTagID] PRIMARY KEY CLUSTERED ([ParameterTimeTagID] ASC),
    CONSTRAINT [FK_ParameterTimeTag_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_ParameterTimeTag_PatientChannel_PatientChannelID] FOREIGN KEY ([PatientChannelID]) REFERENCES [dbo].[PatientChannel] ([PatientChannelID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ParamTimeTag_PatientID_TimeTagType_PatientChannelID_ParamDateTime]
    ON [dbo].[ParameterTimeTag]([PatientID] ASC, [TimeTagType] ASC, [PatientChannelID] ASC, [ParamDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ParameterTimeTag_TimeTagType_PatientID_ParamDateTime]
    ON [dbo].[ParameterTimeTag]([TimeTagType] ASC, [PatientID] ASC, [ParamDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ParameterTimeTag_PatientID_TimeTagType_ParamDateTime]
    ON [dbo].[ParameterTimeTag]([PatientID] ASC, [TimeTagType] ASC, [ParamDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ParameterTimeTag_Patient_PatientID]
    ON [dbo].[ParameterTimeTag]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ParameterTimeTag_PatientChannel_PatientChannelID]
    ON [dbo].[ParameterTimeTag]([PatientChannelID] ASC);

