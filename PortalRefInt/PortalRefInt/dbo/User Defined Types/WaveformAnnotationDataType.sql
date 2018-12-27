CREATE TYPE [dbo].[WaveformAnnotationDataType] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [PrintRequestId] BIGINT NOT NULL,
    [ChannelIndex]   INT              NOT NULL,
    [Annotation]     VARCHAR (MAX)    NOT NULL);

