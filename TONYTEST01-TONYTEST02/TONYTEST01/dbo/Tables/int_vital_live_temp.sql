CREATE TABLE [dbo].[int_vital_live_temp] (
    [patient_id]      UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id] UNIQUEIDENTIFIER NULL,
    [monitor_id]      UNIQUEIDENTIFIER NOT NULL,
    [collect_dt]      DATETIME         NOT NULL,
    [vital_value]     VARCHAR (4000)   NOT NULL,
    [vital_time]      VARCHAR (3950)   NULL,
    [createdDT]       DATETIME         CONSTRAINT [DF_int_vital_live_temp_creattime] DEFAULT (getdate()) NULL
);


GO
CREATE CLUSTERED INDEX [IDX_int_vital_live_temp_1]
    ON [dbo].[int_vital_live_temp]([createdDT] ASC);


GO

CREATE TRIGGER [dbo].[RefreshVitalDataCopy]
ON [dbo].[int_vital_live_temp]
AFTER INSERT
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    --Keep data for two minutes most
    DELETE int_vital_live_temp
    WHERE  createdDT < GetDate( ) - 0.002

  END

