CREATE TABLE [dbo].[WaveformAnnotationData] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [PrintRequestId] UNIQUEIDENTIFIER NOT NULL,
    [ChannelIndex]   INT              NOT NULL,
    [Annotation]     VARCHAR (MAX)    NOT NULL
);

