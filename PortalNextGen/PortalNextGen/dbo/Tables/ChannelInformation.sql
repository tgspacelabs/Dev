﻿CREATE TABLE [dbo].[ChannelInformation] (
    [ChannelInformationID] INT           IDENTITY (1, 1) NOT NULL,
    [PrintRequestID]       INT           NOT NULL,
    [ChannelIndex]         INT           NOT NULL,
    [IsPrimaryECG]         BIT           NOT NULL,
    [IsSecondaryECG]       BIT           NOT NULL,
    [IsNonWaveformType]    BIT           NOT NULL,
    [SampleRate]           INT           NULL,
    [Scale]                INT           NULL,
    [ScaleValue]           FLOAT (53)    NULL,
    [ScaleMin]             FLOAT (53)    NULL,
    [ScaleMax]             FLOAT (53)    NULL,
    [ScaleTypeEnumValue]   INT           NULL,
    [Baseline]             INT           NULL,
    [YPointsPerUnit]       INT           NULL,
    [ChannelTypeID]        INT           NOT NULL,
    [CreatedDateTime]      DATETIME2 (7) CONSTRAINT [DF_ChannelInformation_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ChannelInformation_ChannelInformationID] PRIMARY KEY CLUSTERED ([ChannelInformationID] ASC),
    CONSTRAINT [FK_ChannelInformation_ChannelType_ChannelTypeID] FOREIGN KEY ([ChannelTypeID]) REFERENCES [dbo].[ChannelType] ([ChannelTypeID]),
    CONSTRAINT [FK_ChannelInformation_PrintRequest_PrintRequestID] FOREIGN KEY ([PrintRequestID]) REFERENCES [dbo].[PrintRequest] ([PrintRequestID])
);


GO
CREATE NONCLUSTERED INDEX [FK_ChannelInformation_ChannelType_ChannelTypeID]
    ON [dbo].[ChannelInformation]([ChannelTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ChannelInformation_PrintRequest_PrintRequestID]
    ON [dbo].[ChannelInformation]([PrintRequestID] ASC);

