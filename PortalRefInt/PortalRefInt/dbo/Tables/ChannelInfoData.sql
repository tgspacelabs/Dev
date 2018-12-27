﻿CREATE TABLE [dbo].[ChannelInfoData] (
    [Id]                 BIGINT NOT NULL,
    [PrintRequestId]     BIGINT NOT NULL,
    [ChannelIndex]       INT              NOT NULL,
    [IsPrimaryECG]       BIT              NOT NULL,
    [IsSecondaryECG]     BIT              NOT NULL,
    [IsNonWaveformType]  BIT              NOT NULL,
    [SampleRate]         INT              NULL,
    [Scale]              INT              NULL,
    [ScaleValue]         FLOAT (53)       NULL,
    [ScaleMin]           FLOAT (53)       NULL,
    [ScaleMax]           FLOAT (53)       NULL,
    [ScaleTypeEnumValue] INT              NULL,
    [Baseline]           INT              NULL,
    [YPointsPerUnit]     INT              NULL,
    [ChannelType]        INT              NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChannelInfoData';

