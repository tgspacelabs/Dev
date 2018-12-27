CREATE TABLE [dbo].[PrintBlobData] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [PrintRequestId] UNIQUEIDENTIFIER NOT NULL,
    [NumBytes]       INT              NOT NULL,
    [Value]          VARBINARY (MAX)  NOT NULL
);

