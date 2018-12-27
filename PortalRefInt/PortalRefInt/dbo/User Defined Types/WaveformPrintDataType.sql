CREATE TYPE [dbo].[WaveformPrintDataType] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [PrintRequestId] BIGINT NOT NULL,
    [ChannelIndex]   INT              NOT NULL,
    [NumSamples]     INT              NOT NULL,
    [Samples]        VARCHAR (MAX)    NOT NULL);

