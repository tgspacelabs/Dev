CREATE TABLE [dbo].[ConversionErrors] (
    [ObjectType]       NVARCHAR (255) NULL,
    [ObjectName]       NVARCHAR (255) NULL,
    [ErrorDescription] NVARCHAR (MAX) NULL,
    [SSMA_TimeStamp]   ROWVERSION     NOT NULL,
    CONSTRAINT [SSMA_CC$ConversionErrors$ErrorDescription$disallow_zero_length] CHECK (len([ErrorDescription])>(0)),
    CONSTRAINT [SSMA_CC$ConversionErrors$ObjectName$disallow_zero_length] CHECK (len([ObjectName])>(0)),
    CONSTRAINT [SSMA_CC$ConversionErrors$ObjectType$disallow_zero_length] CHECK (len([ObjectType])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[ConversionErrors]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConversionErrors';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[ConversionErrors].[Object Type]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConversionErrors', @level2type = N'COLUMN', @level2name = N'ObjectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[ConversionErrors].[Object Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConversionErrors', @level2type = N'COLUMN', @level2name = N'ObjectName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[ConversionErrors].[Error Description]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConversionErrors', @level2type = N'COLUMN', @level2name = N'ErrorDescription';

