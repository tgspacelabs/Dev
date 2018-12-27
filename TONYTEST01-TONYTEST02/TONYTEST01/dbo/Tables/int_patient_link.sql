﻿CREATE TABLE [dbo].[int_patient_link] (
    [orig_patient_id] UNIQUEIDENTIFIER NOT NULL,
    [new_patient_id]  UNIQUEIDENTIFIER NOT NULL,
    [user_id]         UNIQUEIDENTIFIER NULL,
    [monitor_id]      UNIQUEIDENTIFIER NULL,
    [mod_dt]          DATETIME         NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [patient_link_idx]
    ON [dbo].[int_patient_link]([orig_patient_id] ASC, [new_patient_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table tracks all patients that have been linked or merged. It allows patients to be linked (i.e. they are identified to be the same patient). It also allows patients to later be unlinked if they were mistakenly linked.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_patient_link';
