CREATE TABLE [dbo].[int_send_sys] (
    [sys_id]          BIGINT NOT NULL,
    [organization_id] BIGINT NOT NULL,
    [code]            NVARCHAR (180)   NOT NULL,
    [dsc]             NVARCHAR (180)   NULL,
    CONSTRAINT [FK_int_send_sys_int_organization_organization_id] FOREIGN KEY ([organization_id]) REFERENCES [dbo].[int_organization] ([organization_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_send_sys_sys_id]
    ON [dbo].[int_send_sys]([sys_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains information for each system sending messages to be stored in the CIS database. Specifically, all system codes defined in the message header (MSH) Sending Application and Receiving Application fields must be loaded in this table. All system codes that are sent as application id''s for placer order numbers and filler order number (see HL7 segments ORC, OBR, and OBX) must be loaded into this table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_send_sys';

