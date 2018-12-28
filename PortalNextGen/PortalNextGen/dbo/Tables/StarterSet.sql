CREATE TABLE [dbo].[StarterSet] (
    [StarterSetID]    INT            IDENTITY (1, 1) NOT NULL,
    [SetTypeCode]     NVARCHAR (255) NULL,
    [Guid]            NVARCHAR (255) NULL,
    [ID1]             FLOAT (53)     NULL,
    [ID2]             FLOAT (53)     NULL,
    [ID3]             FLOAT (53)     NULL,
    [Enu]             NVARCHAR (255) NULL,
    [Fra]             NVARCHAR (255) NULL,
    [Deu]             NVARCHAR (255) NULL,
    [Esp]             NVARCHAR (255) NULL,
    [Ita]             NVARCHAR (255) NULL,
    [Nld]             NVARCHAR (255) NULL,
    [Chs]             NVARCHAR (255) NULL,
    [Cze]             NVARCHAR (255) NULL,
    [Pol]             NVARCHAR (255) NULL,
    [Ptb]             NVARCHAR (255) NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_StarterSet_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_StarterSet_StarterSetID] PRIMARY KEY CLUSTERED ([StarterSetID] ASC)
);

