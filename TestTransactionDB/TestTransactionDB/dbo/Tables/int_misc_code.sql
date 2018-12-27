CREATE TABLE [dbo].[int_misc_code] (
    [code_id]         INT              NOT NULL,
    [organization_id] UNIQUEIDENTIFIER NULL,
    [sys_id]          UNIQUEIDENTIFIER NULL,
    [category_cd]     CHAR (4)         NULL,
    [method_cd]       NVARCHAR (10)    NULL,
    [code]            NVARCHAR (80)    NULL,
    [verification_sw] TINYINT          NULL,
    [int_keystone_cd] NVARCHAR (80)    NULL,
    [short_dsc]       NVARCHAR (100)   NULL,
    [spc_pcs_code]    CHAR (1)         NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_int_misc_code_code_id]
    ON [dbo].[int_misc_code]([code_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_code]
    ON [dbo].[int_misc_code]([code] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_int_keystone_cd]
    ON [dbo].[int_misc_code]([int_keystone_cd] ASC) WITH (FILLFACTOR = 65);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_int_misc_code_code_id_code_int_keystone_cd]
    ON [dbo].[int_misc_code]([code_id] ASC)
    INCLUDE([code], [int_keystone_cd]) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_int_misc_code_category_cd_code_organization_id_sys_id_method_cd]
    ON [dbo].[int_misc_code]([category_cd] ASC, [code] ASC, [organization_id] ASC, [sys_id] ASC, [method_cd] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_code_short_dsc_int_keystone_cd]
    ON [dbo].[int_misc_code]([code] ASC, [short_dsc] ASC, [int_keystone_cd] ASC) WITH (FILLFACTOR = 80);

