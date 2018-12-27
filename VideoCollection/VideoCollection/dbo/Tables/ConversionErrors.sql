CREATE TABLE [dbo].[ConversionErrors] (
    [ObjectType]       NVARCHAR (255) NULL,
    [ObjectName]       NVARCHAR (255) NULL,
    [ErrorDescription] NVARCHAR (MAX) NULL,
    [SSMA_TimeStamp]   ROWVERSION     NOT NULL
);

