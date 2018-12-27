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
    ON [dbo].[int_vital_live]([patient_id] ASC, [monitor_id] ASC, [collect_dt] ASC);


GO


CREATE TRIGGER [dbo].[FillVitalCopyTempTable]
ON [dbo].[int_vital_live]
AFTER UPDATE, INSERT
AS
  BEGIN
    SET NOCOUNT ON

    INSERT INTO int_vital_live_temp
                (patient_id,
                 orig_patient_id,
                 monitor_id,
                 collect_dt,
                 vital_value,
                 vital_time)
      SELECT *
      FROM   inserted
      WHERE  inserted.vital_time IS NOT NULL

  END

