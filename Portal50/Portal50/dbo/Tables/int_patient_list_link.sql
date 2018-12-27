﻿CREATE TABLE [dbo].[int_patient_list_link] (
    [master_owner_id]   UNIQUEIDENTIFIER NOT NULL,
    [transfer_owner_id] UNIQUEIDENTIFIER NOT NULL,
    [patient_id]        UNIQUEIDENTIFIER NULL,
    [start_dt]          DATETIME         NOT NULL,
    [end_dt]            DATETIME         NULL,
    [type_cd]           CHAR (1)         NOT NULL,
    [deleted]           TINYINT          NULL
);


GO
CREATE CLUSTERED INDEX [int_patient_list_link_ndx]
    ON [dbo].[int_patient_list_link]([master_owner_id] ASC, [transfer_owner_id] ASC, [patient_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table allows a user (usually a physician) to allow other users to view their patients. One typical usage is when a physician takes vacation and needs to "assign" patients to another physician for coverage. This table allows either complete assignment (all patients), or individual patients.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_patient_list_link';
