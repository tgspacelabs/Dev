
CREATE PROCEDURE [dbo].[SetPatientDataCollect]
    (
     @patientId UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_patient_monitor]
    SET
        [live_until_dt] = DATEADD(MINUTE, 3, GETDATE( ))
    WHERE
        [patient_id] = @patientId
        AND [active_sw] = 1;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'SetPatientDataCollect';

