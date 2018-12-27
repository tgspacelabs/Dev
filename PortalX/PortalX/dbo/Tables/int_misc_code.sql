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
CREATE UNIQUE CLUSTERED INDEX [CL_int_misc_code_code_id]
    ON [dbo].[int_misc_code]([code_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_int_misc_code_category_cd_code_organization_id_sys_id_method_cd]
    ON [dbo].[int_misc_code]([category_cd] ASC, [code] ASC, [organization_id] ASC, [sys_id] ASC, [method_cd] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_int_keystone_cd]
    ON [dbo].[int_misc_code]([int_keystone_cd] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_code]
    ON [dbo].[int_misc_code]([code] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_code_short_dsc_int_keystone_cd]
    ON [dbo].[int_misc_code]([code] ASC, [short_dsc] ASC, [int_keystone_cd] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_misc_code_short_dsc_code_int_keystone_cd]
    ON [dbo].[int_misc_code]([short_dsc] ASC, [code] ASC, [int_keystone_cd] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores multiple code sets (miscellaneous codes). It stores many of the codified fields that HL/7 defines. All of these codes can be dynamically added by the back-end (DataLoader). However to ensure good descriptions of the code (for display), it is necessary for the administrator to update these dynamically added codes. Codes are unique for a given organization, feeder system and category (cat_code).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_misc_code';

