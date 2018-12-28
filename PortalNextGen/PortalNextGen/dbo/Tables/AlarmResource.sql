CREATE TABLE [dbo].[AlarmResource] (
    [AlarmResourceID] INT            IDENTITY (1, 1) NOT NULL,
    [EnumGroupID]     INT            NOT NULL,
    [IDEnumValue]     INT            NOT NULL,
    [Label]           NVARCHAR (250) NOT NULL,
    [StrMessage]      NVARCHAR (250) NOT NULL,
    [StrLimitFormat]  NVARCHAR (250) NOT NULL,
    [StrValueFormat]  NVARCHAR (250) NOT NULL,
    [Locale]          VARCHAR (7)    NOT NULL,
    [Message]         NVARCHAR (250) NOT NULL,
    [LimitFormat]     NVARCHAR (250) NOT NULL,
    [ValueFormat]     NVARCHAR (250) NOT NULL,
    [AlarmTypeName]   NVARCHAR (50)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_AlarmResource_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AlarmResource_AlarmResourceID] PRIMARY KEY CLUSTERED ([AlarmResourceID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AlarmResources_Locale_EnumGroupIdIDEnumValue]
    ON [dbo].[AlarmResource]([Locale] ASC, [EnumGroupID] ASC, [IDEnumValue] ASC);

