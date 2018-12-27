CREATE TABLE [dbo].[int_vital_live_temp] (
    [patient_id]      BIGINT NOT NULL,
    [orig_patient_id] BIGINT NULL,
    [monitor_id]      BIGINT NOT NULL,
    [collect_dt]      DATETIME         NOT NULL,
    [vital_value]     VARCHAR (4000)   NOT NULL,
    [vital_time]      VARCHAR (3950)   NULL,
    [createdDT]       DATETIME         CONSTRAINT [DF_int_vital_live_temp_creattime] DEFAULT (getdate()) NULL,
    CONSTRAINT [FK_int_vital_live_temp_int_monitor_monitor_id] FOREIGN KEY ([monitor_id]) REFERENCES [dbo].[int_monitor] ([monitor_id])
);


GO
CREATE CLUSTERED INDEX [CL_int_vital_live_temp_createdDT]
    ON [dbo].[int_vital_live_temp]([createdDT] ASC) WITH (FILLFACTOR = 100);


GO
CREATE TRIGGER [dbo].[trgRefreshVitalDataCopy] ON [dbo].[int_vital_live_temp]
    AFTER INSERT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    --Keep data for two minutes most
    DELETE FROM
        [dbo].[int_vital_live_temp]
    WHERE
        [createdDT] < GETDATE( ) - 0.002;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_vital_live_temp';

