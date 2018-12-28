CREATE TABLE [dbo].[ValueGlobal] (
    [ValueGlobalID]         INT             IDENTITY (1, 1) NOT NULL,
    [TypeCode]              VARCHAR (25)    NOT NULL,
    [ConfigurationName]     VARCHAR (40)    NOT NULL,
    [ConfigurationValue]    NVARCHAR (1800) NULL,
    [ConfigurationXmlValue] XML             NULL,
    [ValueType]             VARCHAR (20)    NOT NULL,
    [GlobalType]            BIT             NOT NULL,
    [CreatedDateTime]       DATETIME2 (7)   CONSTRAINT [DF_ValueGlobal_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ValueGlobal_ValueGlobalID] PRIMARY KEY CLUSTERED ([ValueGlobalID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ValueGlobal_TypeCode_ConfigurationName]
    ON [dbo].[ValueGlobal]([TypeCode] ASC, [ConfigurationName] ASC);

