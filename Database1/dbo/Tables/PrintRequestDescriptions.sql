CREATE TABLE [dbo].[PrintRequestDescriptions] (
    [RequestTypeEnumId]    UNIQUEIDENTIFIER NOT NULL,
    [RequestTypeEnumValue] INT              NOT NULL,
    [Value]                VARCHAR (25)     NOT NULL,
    CONSTRAINT [PK_PrintRequestDescriptions_RequestTypeEnumId_RequestTypeEnumValue] PRIMARY KEY CLUSTERED ([RequestTypeEnumId] ASC, [RequestTypeEnumValue] ASC) WITH (FILLFACTOR = 100)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PrintRequestDescriptions';

