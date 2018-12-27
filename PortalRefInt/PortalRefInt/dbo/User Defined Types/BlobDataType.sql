CREATE TYPE [dbo].[BlobDataType] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [PrintRequestId] BIGINT NOT NULL,
    [NumBytes]       INT              NOT NULL,
    [Value]          VARBINARY (MAX)  NOT NULL);

