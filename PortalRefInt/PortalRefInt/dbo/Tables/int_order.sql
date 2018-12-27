CREATE TABLE [dbo].[int_order] (
    [encounter_id]    BIGINT NOT NULL,
    [order_id]        BIGINT NOT NULL,
    [patient_id]      BIGINT NOT NULL,
    [orig_patient_id] BIGINT NULL,
    [priority_cid]    INT              NULL,
    [status_cid]      INT              NULL,
    [univ_svc_cid]    INT              NULL,
    [order_person_id] BIGINT NULL,
    [order_dt]        DATETIME         NULL,
    [enter_id]        BIGINT NULL,
    [verif_id]        BIGINT NULL,
    [transcriber_id]  BIGINT NULL,
    [parent_order_id] BIGINT NULL,
    [child_order_sw]  TINYINT          NULL,
    [order_cntl_cid]  INT              NULL,
    [history_sw]      TINYINT          NULL,
    [monitor_sw]      TINYINT          NULL,
    CONSTRAINT [FK_int_order_int_patient_patient_id] FOREIGN KEY ([patient_id]) REFERENCES [dbo].[int_patient] ([patient_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_order_patient_id_order_id_encounter_id]
    ON [dbo].[int_order]([patient_id] ASC, [order_id] ASC, [encounter_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_order_id_encounter_id]
    ON [dbo].[int_order]([encounter_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores all orders for every patient.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_order';

