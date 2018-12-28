﻿CREATE TABLE [dbo].[PrintJobWaveform] (
    [PrintJobWaveformID]      INT           IDENTITY (1, 1) NOT NULL,
    [PrintJobID]              INT           NOT NULL,
    [PageNumber]              INT           NOT NULL,
    [SequenceNumber]          INT           NOT NULL,
    [WaveformType]            VARCHAR (25)  NOT NULL,
    [duration]                FLOAT (53)    NULL,
    [ChannelType]             VARCHAR (50)  NULL,
    [ModuleNumber]            INT           NULL,
    [ChannelNumber]           INT           NULL,
    [SweepSpeed]              FLOAT (53)    NULL,
    [label_min]               FLOAT (53)    NULL,
    [label_max]               FLOAT (53)    NULL,
    [show_units]              TINYINT       NULL,
    [annotation_channel_type] INT           NULL,
    [offset]                  INT           NULL,
    [scale]                   INT           NULL,
    [primary_annotation]      VARCHAR (50)  NULL,
    [secondary_annotation]    VARCHAR (50)  NULL,
    [WaveformData]            VARCHAR (MAX) NULL,
    [grid_type]               INT           NULL,
    [scale_labels]            VARCHAR (120) NULL,
    [RowDateTime]             SMALLDATETIME CONSTRAINT [DF_PrintJobWaveform_RowDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [RowID]                   INT           CONSTRAINT [DF_PrintJobWaveform_RowID] DEFAULT ((0)) NOT NULL,
    [CreatedDateTime]         DATETIME2 (7) CONSTRAINT [DF_PrintJobWaveform_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintJobWaveform_PrintJobWaveformID] PRIMARY KEY CLUSTERED ([PrintJobWaveformID] ASC),
    CONSTRAINT [FK_PrintJobWaveform_PrintJob_PrintJobID] FOREIGN KEY ([PrintJobID]) REFERENCES [dbo].[PrintJob] ([PrintJobID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PrintJobWaveform_RowDateTime_RowID]
    ON [dbo].[PrintJobWaveform]([RowDateTime] ASC, [RowID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PrintJobWaveform_PrintJobID_PageNumber_SequenceNumber_ModuleNumber_ChannelNumber]
    ON [dbo].[PrintJobWaveform]([PrintJobID] ASC, [PageNumber] ASC, [SequenceNumber] ASC, [ModuleNumber] ASC, [ChannelNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobWaveform_PrintJob_PrintJobID]
    ON [dbo].[PrintJobWaveform]([PrintJobID] ASC);

