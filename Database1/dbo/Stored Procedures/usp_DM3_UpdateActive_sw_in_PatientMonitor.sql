﻿
CREATE PROCEDURE [dbo].[usp_DM3_UpdateActive_sw_in_PatientMonitor]
    (
     @MonitorID NVARCHAR(50)
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_patient_monitor]
    SET
        [active_sw] = NULL
    WHERE
        [monitor_id] = @MonitorID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateActive_sw_in_PatientMonitor';

