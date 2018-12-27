﻿CREATE TABLE [dbo].[PrintRequests] (
    [Id]                   BIGINT NOT NULL,
    [PrintJobId]           BIGINT NOT NULL,
    [RequestTypeEnumId]    BIGINT NOT NULL,
    [RequestTypeEnumValue] INT              NOT NULL,
    [TimestampUTC]         DATETIME         NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PrintRequests';
