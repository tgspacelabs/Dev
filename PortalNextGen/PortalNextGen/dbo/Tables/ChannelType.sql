CREATE TABLE [dbo].[ChannelType] (
    [ChannelTypeID]          INT           IDENTITY (1, 1) NOT NULL,
    [ChannelCode]            INT           NOT NULL,
    [GlobalDataSystemCodeID] INT           NOT NULL,
    [Label]                  VARCHAR (20)  NOT NULL,
    [Frequency]              SMALLINT      NOT NULL,
    [MinimumValue]           SMALLINT      NOT NULL,
    [MaximumValue]           SMALLINT      NOT NULL,
    [SweepSpeed]             FLOAT (53)    NOT NULL,
    [Priority]               TINYINT       NOT NULL,
    [TypeCode]               VARCHAR (10)  NOT NULL,
    [Color]                  VARCHAR (25)  NOT NULL,
    [Units]                  VARCHAR (10)  NOT NULL,
    [CreatedDateTime]        DATETIME2 (7) CONSTRAINT [DF_ChannelType_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ChannelType_ChannelTypeID] PRIMARY KEY CLUSTERED ([ChannelTypeID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ChannelType_ChannelCode_Label]
    ON [dbo].[ChannelType]([ChannelCode] ASC);

