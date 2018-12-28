CREATE TABLE [dbo].[ValueFactory] (
    [ValueFactoryID]        INT             IDENTITY (1, 1) NOT NULL,
    [TypeCode]              VARCHAR (25)    NOT NULL,
    [ConfigurationName]     VARCHAR (40)    NOT NULL,
    [ConfigurationValue]    NVARCHAR (1800) NULL,
    [ConfigurationXmlValue] XML             NULL,
    [ValueType]             VARCHAR (20)    NOT NULL,
    [GlobalType]            BIT             NOT NULL,
    [CreatedDateTime]       DATETIME2 (7)   CONSTRAINT [DF_ValueFactory_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ValueFactory_ValueFactoryID] PRIMARY KEY CLUSTERED ([ValueFactoryID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ValuesFactory_TypeCode_ConfigurationName]
    ON [dbo].[ValueFactory]([TypeCode] ASC, [ConfigurationName] ASC);

