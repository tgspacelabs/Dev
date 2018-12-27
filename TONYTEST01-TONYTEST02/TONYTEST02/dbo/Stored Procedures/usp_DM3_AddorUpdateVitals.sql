
CREATE PROCEDURE [dbo].[usp_DM3_AddorUpdateVitals]
  (
	@PatientGUID	NVARCHAR(50),
	@Monitor_Id		NVARCHAR(50),
	@Collect_Date	NVARCHAR(50),
	@Vital_Value	NVARCHAR(4000),
	@Vital_Time		NVARCHAR(3950) = NULL
	)
AS
BEGIN
	IF exists(Select 1 From int_vital_live where patient_id = @PatientGUID and monitor_id = @Monitor_Id)
      BEGIN
        update int_vital_live set collect_dt = @Collect_Date, vital_value = @Vital_Value, vital_time = @Vital_Time where patient_id = @PatientGUID and monitor_id = @Monitor_Id
       END
    ELSE
      BEGIN
        insert into int_vital_live (patient_id , monitor_id , collect_dt, vital_value, vital_time) values (@PatientGUID,@Monitor_Id,@Collect_Date,@Vital_Value,@Vital_Time)
       END
END

