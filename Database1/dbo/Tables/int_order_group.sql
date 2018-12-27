CREATE TABLE [dbo].[int_order_group] (
    [node_id]         INT           NOT NULL,
    [rank]            INT           NOT NULL,
    [parent_node_id]  INT           NULL,
    [node_name]       NVARCHAR (80) NOT NULL,
    [display_in_menu] TINYINT       NULL
);


GO
CREATE CLUSTERED INDEX [ord_group_ndx]
    ON [dbo].[int_order_group]([node_id] ASC, [parent_node_id] ASC, [node_name] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ord_rank]
    ON [dbo].[int_order_group]([rank] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table defines the grouping of orders and how they should appear in the order index. The Order Index displays groups of USID''s and this table defines those groups.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_order_group';

