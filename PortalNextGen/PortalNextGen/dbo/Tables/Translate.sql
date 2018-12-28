CREATE TABLE [dbo].[Translate] (
    [TranslateID]     INT            IDENTITY (1, 1) NOT NULL,
    [TranslateCode]   VARCHAR (70)   NOT NULL,
    [FormID]          VARCHAR (30)   NULL,
    [enu]             NVARCHAR (255) NULL,
    [fra]             NVARCHAR (255) NULL,
    [deu]             NVARCHAR (255) NULL,
    [esp]             NVARCHAR (255) NULL,
    [ita]             NVARCHAR (255) NULL,
    [nld]             NVARCHAR (255) NULL,
    [chs]             NVARCHAR (255) NULL,
    [InsertDateTime]  DATETIME2 (7)  NOT NULL,
    [Pol]             NVARCHAR (255) NULL,
    [ptb]             NVARCHAR (255) NULL,
    [cze]             NVARCHAR (255) NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_Translate_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Translate_TranslateID] PRIMARY KEY CLUSTERED ([TranslateID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Translate_TranslateCode]
    ON [dbo].[Translate]([TranslateCode] ASC);

