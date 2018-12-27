﻿CREATE TABLE [dbo].[int_procedure] (
    [encounter_id]           INT      NOT NULL,
    [procedure_cid]          INT      NOT NULL,
    [seq_no]                 BIT      NOT NULL,
    [procedure_dt]           DATETIME NOT NULL,
    [procedure_function_cid] INT      NOT NULL,
    [procedure_minutes]      BIT      NOT NULL,
    [anesthesia_cid]         INT      NULL,
    [anesthesia_minutes]     BIT      NULL,
    [consent_cid]            INT      NOT NULL,
    [procedure_priority]     BIT      NULL,
    [assoc_diag_cid]         INT      NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [int_procedure_ndx]
    ON [dbo].[int_procedure]([encounter_id] ASC, [procedure_cid] ASC, [seq_no] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains information relative to various types of procedures that can be performed on a patient.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_procedure';
