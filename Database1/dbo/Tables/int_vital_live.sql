CREATE TABLE [dbo].[int_vital_live] (
    [patient_id]      UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id] UNIQUEIDENTIFIER NULL,
    [monitor_id]      UNIQUEIDENTIFIER NOT NULL,
    [collect_dt]      DATETIME         NOT NULL,
    [vital_value]     VARCHAR (4000)   NOT NULL,
    [vital_time]      VARCHAR (3950)   NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [pkey_ndx]
    ON [dbo].[int_vital_live]([patient_id] ASC, [monitor_id] ASC, [collect_dt] ASC) WITH (FILLFACTOR = 100);


GO

--DROP TRIGGER [dbo].[FillVitalCopyTempTable];
--CREATE TRIGGER [dbo].[FillVitalCopyTempTable] ON [dbo].[int_vital_live]
--DROP TRIGGER [dbo].[tiu_int_vital_live_FillVitalCopyTempTable];
CREATE TRIGGER [dbo].[tiu_int_vital_live_FillVitalCopyTempTable] ON [dbo].[int_vital_live]
    AFTER UPDATE, INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_vital_live_temp]
            ([patient_id],
             [orig_patient_id],
             [monitor_id],
             [collect_dt],
             [vital_value],
             [vital_time]
            )
    SELECT
        [inserted].[patient_id],
        [inserted].[orig_patient_id],
        [inserted].[monitor_id],
        [inserted].[collect_dt],
        [inserted].[vital_value],
        [inserted].[vital_time]
    FROM
        [inserted]
    WHERE
        [inserted].[vital_time] IS NOT NULL;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_vital_live';

