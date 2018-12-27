CREATE TYPE [dbo].[PrintRequestDataType] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [PrintRequestId] BIGINT NOT NULL,
    [Name]           VARCHAR (50)     NULL,
    [Value]          VARCHAR (MAX)    NULL);

