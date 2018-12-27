
CREATE PROCEDURE [dbo].[GetPatientsList]
  (
  @unit_id DUNIT_ID,
  @status  NVARCHAR(40)
  )
AS
  BEGIN
	DECLARE	@return_value table 
	(
						PATIENT_ID UNIQUEIDENTIFIER,
							   PATIENT_NAME NVARCHAR(100),
							   MONITOR_NAME NVARCHAR(30),
							   ACCOUNT_ID NVARCHAR(30),
							   MRN_ID NVARCHAR(30),
							   UNIT_ID UNIQUEIDENTIFIER,
							   organization_cd NVARCHAR(20),
							   FACILITY_ID UNIQUEIDENTIFIER,
								FACILITY_NAME NVARCHAR(20),  
							   DOB DateTime,
							   ADMIT_TIME DateTime,
							   DISCHARGED_TIME DateTime,
							   PATIENT_MONITOR_ID UNIQUEIDENTIFIER,
						  [STATUS] varchar(40)

	)
	insert @return_value exec	[dbo].[GetUserPatientsList]
			@unit_id = @unit_id,
			@status = @status
 
	select * from @return_value

  END


