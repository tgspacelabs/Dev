CREATE TABLE [dbo].[int_cmtry_report] (
    [patient_id]      UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id] UNIQUEIDENTIFIER NULL,
    [report_name]     NVARCHAR (50)    NOT NULL,
    [report_data]     IMAGE            NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [cmtry_ndx]
    ON [dbo].[int_cmtry_report]([patient_id] ASC, [report_name] ASC);

