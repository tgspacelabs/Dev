﻿CREATE TABLE [dbo].[int_12lead_report] (
    [report_id]       BIGINT NOT NULL,
    [patient_id]      BIGINT NOT NULL,
    [orig_patient_id] BIGINT NULL,
    [monitor_id]      BIGINT NOT NULL,
    [report_number]   INT              NOT NULL,
    [report_dt]       DATETIME         NOT NULL,
    [export_sw]       TINYINT          NULL,
    [report_data]     IMAGE            NOT NULL,
    CONSTRAINT [PK_int_12lead_report_report_id_patient_id] PRIMARY KEY CLUSTERED ([report_id] ASC, [patient_id] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_int_12lead_report_int_monitor_monitor_id] FOREIGN KEY ([monitor_id]) REFERENCES [dbo].[int_monitor] ([monitor_id]),
    CONSTRAINT [FK_int_12lead_report_int_patient_patient_id] FOREIGN KEY ([patient_id]) REFERENCES [dbo].[int_patient] ([patient_id])
);


GO
CREATE NONCLUSTERED INDEX [IX_int_12lead_report_report_dt]
    ON [dbo].[int_12lead_report]([report_dt] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the 12 lead reports collected from the monitor. Each record is uniquely identified by the report_id. The data in this table is populated by the monitor loader process.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The unique ID identifying a 12 lead report.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'report_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The unique ID identifying a patient. Foreign key to the int_patient table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'patient_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Original patient ID.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'orig_patient_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The monitor ID.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'monitor_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Report sequence number used along with patient_id and report_dt to create unique ID for 12-Leads reports', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'report_number';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date/time of the 12 lead report.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'report_dt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether the report is active or not(?!?)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'export_sw';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The 12 lead report data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_12lead_report', @level2type = N'COLUMN', @level2name = N'report_data';

