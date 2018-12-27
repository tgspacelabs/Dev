﻿CREATE TABLE [dbo].[int_msg_log] (
    [msg_log_id]      UNIQUEIDENTIFIER NOT NULL,
    [msg_dt]          DATETIME         NOT NULL,
    [product]         NVARCHAR (20)    NOT NULL,
    [msg_template_id] INT              NULL,
    [external_id]     VARCHAR (50)     NULL,
    [msg_text]        NTEXT            NULL,
    [type]            NVARCHAR (20)    NULL
);


GO
CREATE NONCLUSTERED INDEX [msg_log_idx]
    ON [dbo].[int_msg_log]([msg_dt] ASC);


GO
CREATE NONCLUSTERED INDEX [msg_log_template_ndx]
    ON [dbo].[int_msg_log]([msg_template_id] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [msg_log_external_ndx]
    ON [dbo].[int_msg_log]([external_id] ASC, [msg_log_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores messages that are produced from the system back-end. It is used to log messages that may or may not be related to HL/7 processing. Most of the rows in this table come about from informational msgs or errors related to HL/7 processing. Purging of this table may need to be done periodically (or done with the purging of the hl7_in_queue table).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_msg_log';

