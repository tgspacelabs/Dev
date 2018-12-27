CREATE TABLE [dbo].[PurgerLog] (
    [PurgerLogID]  BIGINT         IDENTITY (-9223372036854775808, 1) NOT NULL,
    [Procedure]    VARCHAR (255)  NOT NULL,
    [Table]        VARCHAR (1024) NOT NULL,
    [PurgeDate]    DATETIME2 (7)  NOT NULL,
    [Parameters]   VARCHAR (255)  NOT NULL,
    [ChunkSize]    INT            NOT NULL,
    [Rows]         BIGINT         NOT NULL,
    [ErrorNumber]  INT            NULL,
    [ErrorMessage] NVARCHAR (MAX) NULL,
    [StartTime]    DATETIME2 (7)  CONSTRAINT [DF_PurgerLog_StartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [Created]      DATETIME2 (7)  CONSTRAINT [DF_PurgerLog_Created] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PurgerLog_Created_PurgerLogID] PRIMARY KEY CLUSTERED ([Created] ASC, [PurgerLogID] ASC) WITH (FILLFACTOR = 100)
);

