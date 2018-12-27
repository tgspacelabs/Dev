
CREATE PROCEDURE [dbo].[usp_DM3_UpdateLastPoleDate_ResultDate_in_patientmonitor]
    (
     @Last_Poll_Date NVARCHAR(30) = NULL,
     @PatientGUID NVARCHAR(50),
     @PatientMonitorGUID NVARCHAR(50)
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_patient_monitor]
    SET
        [last_poll_dt] = @Last_Poll_Date,
        [last_result_dt] = @Last_Poll_Date
    WHERE
        [patient_id] = @PatientGUID
        AND [patient_monitor_id] = @PatientMonitorGUID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateLastPoleDate_ResultDate_in_patientmonitor';

