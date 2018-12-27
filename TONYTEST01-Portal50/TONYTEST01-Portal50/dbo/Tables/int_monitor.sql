CREATE TABLE [dbo].[int_monitor] (
    [monitor_id]      UNIQUEIDENTIFIER NOT NULL,
    [unit_org_id]     UNIQUEIDENTIFIER NULL,
    [network_id]      NVARCHAR (15)    NOT NULL,
    [node_id]         NVARCHAR (15)    NOT NULL,
    [bed_id]          NVARCHAR (3)     NOT NULL,
    [bed_cd]          NVARCHAR (20)    NULL,
    [room]            NVARCHAR (12)    NULL,
    [monitor_dsc]     NVARCHAR (50)    NULL,
    [monitor_name]    NVARCHAR (30)    NOT NULL,
    [monitor_type_cd] VARCHAR (5)      NULL,
    [subnet]          NVARCHAR (50)    NULL,
    [standby]         TINYINT          NULL
);


GO
CREATE CLUSTERED INDEX [pkey_ndx]
    ON [dbo].[int_monitor]([monitor_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ndx_gateway]
    ON [dbo].[int_monitor]([unit_org_id] ASC, [network_id] ASC, [node_id] ASC, [bed_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores all monitors known by all gateways. Records are dynamically added/updated in this table as the monitor Loader service(s) run. Monitor records are NOT dynamically removed.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_monitor';

