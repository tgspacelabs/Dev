CREATE TABLE [dbo].[int_guarantor] (
    [patient_id]          BIGINT NOT NULL,
    [seq_no]              INT              NOT NULL,
    [type_cd]             NCHAR (2)        NOT NULL,
    [active_sw]           TINYINT          NOT NULL,
    [orig_patient_id]     BIGINT NULL,
    [relationship_cid]    INT              NULL,
    [encounter_id]        BIGINT NULL,
    [ext_organization_id] BIGINT NULL,
    [guarantor_person_id] BIGINT NULL,
    [employer_id]         BIGINT NULL,
    [spouse_id]           BIGINT NULL,
    [contact_id]          BIGINT NULL,
    CONSTRAINT [FK_int_guarantor_int_diagnosis_encounter_id] FOREIGN KEY ([encounter_id]) REFERENCES [dbo].[int_diagnosis] ([encounter_id]),
    CONSTRAINT [FK_int_guarantor_int_encounter_encounter_id] FOREIGN KEY ([encounter_id]) REFERENCES [dbo].[int_encounter] ([encounter_id]),
    CONSTRAINT [FK_int_guarantor_int_external_organization_ext_organization_id] FOREIGN KEY ([ext_organization_id]) REFERENCES [dbo].[int_external_organization] ([ext_organization_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_guarantor_patient_id_seq_no]
    ON [dbo].[int_guarantor]([patient_id] ASC, [seq_no] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores guarantor information supplied in the GT1 segment of HL/7.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_guarantor';

