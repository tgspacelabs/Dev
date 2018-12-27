CREATE TABLE [dbo].[PrintRequests] (
    [Id]                   UNIQUEIDENTIFIER NOT NULL,
    [PrintJobId]           UNIQUEIDENTIFIER NOT NULL,
    [RequestTypeEnumId]    UNIQUEIDENTIFIER NOT NULL,
    [RequestTypeEnumValue] INT              NOT NULL,
    [TimestampUTC]         DATETIME         NOT NULL
);

