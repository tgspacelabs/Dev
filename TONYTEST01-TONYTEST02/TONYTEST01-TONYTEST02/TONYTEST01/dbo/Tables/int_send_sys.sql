﻿CREATE TABLE [dbo].[int_send_sys] (
    [sys_id]          UNIQUEIDENTIFIER NOT NULL,
    [organization_id] UNIQUEIDENTIFIER NOT NULL,
    [code]            NVARCHAR (180)   NOT NULL,
    [dsc]             NVARCHAR (180)   NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [send_sys_idx]
    ON [dbo].[int_send_sys]([sys_id] ASC);


GO
CREATE NONCLUSTERED INDEX [send_sys_ndx1]
    ON [dbo].[int_send_sys]([code] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains information for each system sending messages to be stored in the CIS database. Specifically, all system codes defined in the message header (MSH) Sending Application and Receiving Application fields must be loaded in this table. All system codes that are sent as application id''s for placer order numbers and filler order number (see HL7 segments ORC, OBR, and OBX) must be loaded into this table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_send_sys';
