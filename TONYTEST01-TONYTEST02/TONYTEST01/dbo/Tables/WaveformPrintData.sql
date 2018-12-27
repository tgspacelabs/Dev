CREATE TABLE [dbo].[WaveformPrintData] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [PrintRequestId] UNIQUEIDENTIFIER NOT NULL,
    [ChannelIndex]   INT              NOT NULL,
    [NumSamples]     INT              NOT NULL,
    [Samples]        VARCHAR (MAX)    NOT NULL
);

