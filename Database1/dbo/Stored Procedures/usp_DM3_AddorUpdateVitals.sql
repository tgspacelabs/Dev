

CREATE PROCEDURE [dbo].[usp_DM3_AddorUpdateVitals]
    (
     @PatientGUID NVARCHAR(50),
     @Monitor_Id NVARCHAR(50),
     @Collect_Date NVARCHAR(50),
     @Vital_Value NVARCHAR(4000),
     @Vital_Time NVARCHAR(3950) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS ( SELECT
                    1
                FROM
                    [dbo].[int_vital_live]
                WHERE
                    [patient_id] = @PatientGUID
                    AND [monitor_id] = @Monitor_Id )
    BEGIN
        UPDATE
            [dbo].[int_vital_live]
        SET
            [collect_dt] = @Collect_Date,
            [vital_value] = @Vital_Value,
            [vital_time] = @Vital_Time
        WHERE
            [patient_id] = @PatientGUID
            AND [monitor_id] = @Monitor_Id;
    END;
    ELSE
    BEGIN
        INSERT  INTO [dbo].[int_vital_live]
                ([patient_id],
                 [monitor_id],
                 [collect_dt],
                 [vital_value],
                 [vital_time]
                )
        VALUES
                (@PatientGUID,
                 @Monitor_Id,
                 @Collect_Date,
                 @Vital_Value,
                 @Vital_Time
                );
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_AddorUpdateVitals';

