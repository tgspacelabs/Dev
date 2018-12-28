CREATE TABLE [dbo].[BinInformation] (
    [BinInformationID]         INT             IDENTITY (1, 1) NOT NULL,
    [UserID]                   INT             NOT NULL,
    [PatientID]                INT             NOT NULL,
    [TemplateSetIndex]         INT             NOT NULL,
    [TemplateIndex]            INT             NOT NULL,
    [TemplateSetInformationID] INT             NOT NULL,
    [BinNumber]                INT             NOT NULL,
    [Source]                   INT             NOT NULL,
    [BeatCount]                INT             NOT NULL,
    [FirstBeatNumber]          INT             NOT NULL,
    [NonIgnoredCount]          INT             NOT NULL,
    [FirstNonIgnoredBeat]      INT             NOT NULL,
    [iso_offset]               INT             NOT NULL,
    [st_offset]                INT             NOT NULL,
    [i_point]                  INT             NOT NULL,
    [j_point]                  INT             NOT NULL,
    [st_class]                 INT             NOT NULL,
    [SinglesBin]               INT             NOT NULL,
    [EditBin]                  INT             NOT NULL,
    [SubclassNumber]           INT             NOT NULL,
    [BinImage]                 VARBINARY (MAX) NULL,
    [CreatedDateTime]          DATETIME2 (7)   CONSTRAINT [DF_BinInformation_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_BinInformation_BinInformationID] PRIMARY KEY CLUSTERED ([BinInformationID] ASC),
    CONSTRAINT [FK_BinInformation_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_BinInformation_TemplateSetInformation_TemplateSetInformationID] FOREIGN KEY ([TemplateSetInformationID]) REFERENCES [dbo].[TemplateSetInformation] ([TemplateSetInformationID])
);


GO
CREATE NONCLUSTERED INDEX [IX_BinInformation_UserID_PatientID_TemplateSetIndex_TemplateIndex]
    ON [dbo].[BinInformation]([UserID] ASC, [PatientID] ASC, [TemplateSetIndex] ASC, [TemplateIndex] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_BinInformation_Patient_PatientID]
    ON [dbo].[BinInformation]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_BinInformation_TemplateSetInformation_TemplateSetInformationID]
    ON [dbo].[BinInformation]([TemplateSetInformationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_BinInformation_User_UserID]
    ON [dbo].[BinInformation]([UserID] ASC);

