CREATE TABLE [dbo].[PurgerLog] (
    [PurgerLogID]        BIGINT         IDENTITY (-9223372036854775808, 1) NOT NULL,
    [ProcedureName]      VARCHAR (255)  NOT NULL,
    [TableName]          VARCHAR (1024) NOT NULL,
    [PurgeDateTime]      DATETIME2 (7)  NOT NULL,
    [Parameters]         VARCHAR (255)  NOT NULL,
    [ChunkSize]          INT            NOT NULL,
    [Rows]               BIGINT         NOT NULL,
    [ErrorNumber]        INT            CONSTRAINT [DF_PurgerLog_ErrorNumber] DEFAULT ((0)) NOT NULL,
    [ErrorMessage]       NVARCHAR (MAX) CONSTRAINT [DF_PurgerLog_ErrorMessage] DEFAULT (N'') NOT NULL,
    [StartTimeUTC]       DATETIME2 (7)  CONSTRAINT [DF_PurgerLog_StartTimeUTC] DEFAULT (sysutcdatetime()) NOT NULL,
    [CreatedDateTimeUTC] DATETIME2 (7)  CONSTRAINT [DF_PurgerLog_CreateDateUTC] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PurgerLog_CreatedDateTimeUTC_PurgerLogID] PRIMARY KEY CLUSTERED ([CreatedDateTimeUTC] ASC, [PurgerLogID] ASC) WITH (FILLFACTOR = 100)
);

