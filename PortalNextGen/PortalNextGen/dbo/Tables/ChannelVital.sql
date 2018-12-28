CREATE TABLE [dbo].[ChannelVital] (
    [ChannelVitalID]         INT           IDENTITY (1, 1) NOT NULL,
    [ChannelTypeID]          INT           NOT NULL,
    [GlobalDataSystemCodeID] INT           NOT NULL,
    [FormatString]           VARCHAR (50)  NOT NULL,
    [CreatedDateTime]        DATETIME2 (7) CONSTRAINT [DF_ChannelVital_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ChannelVital_ChannelVitalID] PRIMARY KEY CLUSTERED ([ChannelVitalID] ASC),
    CONSTRAINT [FK_ChannelVital_ChannelType_ChannelTypeID] FOREIGN KEY ([ChannelTypeID]) REFERENCES [dbo].[ChannelType] ([ChannelTypeID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ChannelVital_ChannelTypeID_GlobalDataSystemCodeID]
    ON [dbo].[ChannelVital]([ChannelTypeID] ASC, [GlobalDataSystemCodeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ChannelVital_ChannelType_ChannelTypeID]
    ON [dbo].[ChannelVital]([ChannelTypeID] ASC);

