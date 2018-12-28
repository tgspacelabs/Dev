CREATE TABLE [dbo].[GatewayServer] (
    [GatewayServerID] INT           IDENTITY (1, 1) NOT NULL,
    [GatewayID]       INT           NOT NULL,
    [ServerName]      NVARCHAR (50) NOT NULL,
    [Port]            INT           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_GatewayServer_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_GatewayServer_GatewayServerID] PRIMARY KEY CLUSTERED ([GatewayServerID] ASC),
    CONSTRAINT [FK_GatewayServer_Gateway_GatewayID] FOREIGN KEY ([GatewayID]) REFERENCES [dbo].[Gateway] ([GatewayID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_GatewayServer_GatewayID_ServerName]
    ON [dbo].[GatewayServer]([GatewayID] ASC, [ServerName] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_GatewayServer_Gateway_GatewayID]
    ON [dbo].[GatewayServer]([GatewayID] ASC);

