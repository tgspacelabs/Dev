CREATE TABLE [dbo].[int_patient_link] (
    [orig_patient_id] BIGINT NOT NULL,
    [new_patient_id]  BIGINT NOT NULL,
    [user_id]         BIGINT NULL,
    [monitor_id]      BIGINT NULL,
    [mod_dt]          DATETIME         NOT NULL,
    CONSTRAINT [FK_int_patient_link_int_monitor_monitor_id] FOREIGN KEY ([monitor_id]) REFERENCES [dbo].[int_monitor] ([monitor_id]),
    CONSTRAINT [FK_int_patient_link_int_user_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[int_user] ([user_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_int_patient_link_orig_patient_id_new_patient_id]
    ON [dbo].[int_patient_link]([orig_patient_id] ASC, [new_patient_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table tracks all patients that have been linked or merged. It allows patients to be linked (i.e. they are identified to be the same patient). It also allows patients to later be unlinked if they were mistakenly linked.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_patient_link';

