CREATE TABLE [dbo].[int_nok] (
    [patient_id]        BIGINT NOT NULL,
    [seq_no]            INT              NOT NULL,
    [notify_seq_no]     INT              NOT NULL,
    [active_flag]       TINYINT          NOT NULL,
    [orig_patient_id]   BIGINT NULL,
    [nok_person_id]     BIGINT NOT NULL,
    [contact_person_id] BIGINT NULL,
    [relationship_cid]  INT              NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_nok_patient_id_seq_no_notify_seq_no_active_flag]
    ON [dbo].[int_nok]([patient_id] ASC, [seq_no] ASC, [notify_seq_no] ASC, [active_flag] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the Next of Kin for patients. Every patient can have Next of Kin (as defined in the NK1 segment in HL/7). NOK''s are not encounter based, they are patient based. However there can be multiple NOK''s for each patient.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_nok';

