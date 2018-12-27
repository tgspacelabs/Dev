CREATE TABLE [dbo].[int_patient_list_detail] (
    [patient_list_id]   BIGINT NOT NULL,
    [patient_id]        BIGINT NOT NULL,
    [orig_patient_id]   BIGINT NULL,
    [encounter_id]      BIGINT NOT NULL,
    [deleted]           TINYINT          NOT NULL,
    [new_results]       CHAR (1)         NULL,
    [viewed_results_dt] DATETIME         NULL,
    CONSTRAINT [FK_int_patient_list_detail_int_diagnosis_encounter_id] FOREIGN KEY ([encounter_id]) REFERENCES [dbo].[int_diagnosis] ([encounter_id]),
    CONSTRAINT [FK_int_patient_list_detail_int_encounter_encounter_id] FOREIGN KEY ([encounter_id]) REFERENCES [dbo].[int_encounter] ([encounter_id]),
    CONSTRAINT [FK_int_patient_list_detail_int_patient_patient_id] FOREIGN KEY ([patient_id]) REFERENCES [dbo].[int_patient] ([patient_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_patient_list_detail_patient_list_id_patient_id_encounter_id]
    ON [dbo].[int_patient_list_detail]([patient_list_id] ASC, [patient_id] ASC, [encounter_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_patient_list_detail_orig_patient_id]
    ON [dbo].[int_patient_list_detail]([orig_patient_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table defines the patients that exist on a given patient list. It is the detail for a patient list. It therefore contains all patient entries for all patient lists (Unit, practicing, personal, etc.) It does not contain entries for the Search or Group lists (these are generated at run-time).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_patient_list_detail';

