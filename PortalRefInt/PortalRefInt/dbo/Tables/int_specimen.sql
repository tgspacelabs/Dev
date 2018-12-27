CREATE TABLE [dbo].[int_specimen] (
    [specimen_id]              BIGINT NOT NULL,
    [order_id]                 BIGINT NOT NULL,
    [patient_id]               BIGINT NULL,
    [orig_patient_id]          BIGINT NULL,
    [univ_svc_cid]             INT              NULL,
    [status_cid]               INT              NULL,
    [encounter_id]             BIGINT NULL,
    [collect_id]               BIGINT NULL,
    [specimen_xid]             NVARCHAR (15)    NULL,
    [procedure_dt]             DATETIME         NULL,
    [source_cid]               INT              NULL,
    [body_site_cid]            INT              NULL,
    [comment_id]               BIGINT NULL,
    [collect_dt]               DATETIME         NULL,
    [collect_vol_qty]          SMALLINT         NULL,
    [collect_vol_unit_code_id] CHAR (10)        NULL,
    [collect_method]           NVARCHAR (80)    NULL,
    [source_additive]          NVARCHAR (30)    NULL,
    [action_code_id]           CHAR (1)         NULL,
    [call_back_phone_cat_id]   INT              NULL,
    [fields_key]               INT              NULL,
    [receive_dt]               DATETIME         NULL,
    [handle_cid]               INT              NULL,
    [handle_cat_cid]           INT              NULL,
    CONSTRAINT [FK_int_specimen_int_diagnosis_encounter_id] FOREIGN KEY ([encounter_id]) REFERENCES [dbo].[int_diagnosis] ([encounter_id]),
    CONSTRAINT [FK_int_specimen_int_encounter_encounter_id] FOREIGN KEY ([encounter_id]) REFERENCES [dbo].[int_encounter] ([encounter_id]),
    CONSTRAINT [FK_int_specimen_int_patient_patient_id] FOREIGN KEY ([patient_id]) REFERENCES [dbo].[int_patient] ([patient_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_specimen_specimen_id_patient_id]
    ON [dbo].[int_specimen]([specimen_id] ASC, [patient_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to capture information of the SPECIMEN that is associated with the performable test. The important information are the type, source, and when the SPECIMEN was collected. The test processing generally is categorized by the SPECIMEN type. Blood related SPECIMEN usually process in hemetology section, etc.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_specimen';

