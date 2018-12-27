CREATE TABLE [dbo].[PrintBlobData] (
    [Id]             BIGINT NOT NULL,
    [PrintRequestId] BIGINT NOT NULL,
    [NumBytes]       INT              NOT NULL,
    [Value]          VARBINARY (MAX)  NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PrintBlobData';

