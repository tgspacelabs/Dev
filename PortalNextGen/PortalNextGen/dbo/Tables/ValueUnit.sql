CREATE TABLE [dbo].[ValueUnit] (
    [ValueUnitID]           INT             IDENTITY (1, 1) NOT NULL,
    [UnitID]                INT             NOT NULL,
    [TypeCode]              VARCHAR (25)    NOT NULL,
    [ConfigurationName]     VARCHAR (40)    NOT NULL,
    [ConfigurationValue]    NVARCHAR (1800) NULL,
    [ConfigurationXmlValue] XML             NULL,
    [ValueType]             VARCHAR (20)    NOT NULL,
    [CreatedDateTime]       DATETIME2 (7)   CONSTRAINT [DF_ValueUnit_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ValueUnit_ValueUnitID] PRIMARY KEY CLUSTERED ([ValueUnitID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ValueUnit_ValueUnitID]
    ON [dbo].[ValueUnit]([UnitID] ASC, [TypeCode] ASC, [ConfigurationName] ASC);

