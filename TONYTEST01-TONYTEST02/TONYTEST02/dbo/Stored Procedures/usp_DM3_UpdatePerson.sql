-- [UpdatePerson_Dm3] is used to Add or Update Encounter Table values in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_UpdatePerson]
  (
  @LastName				NVARCHAR(50) = NULL,
  @FirstName			NVARCHAR(50) = NULL,
  @MiddleName			NVARCHAR(50) = NULL,
  @ConstLastName		NVARCHAR(50) = NULL,
  @ConstFirstName		NVARCHAR(50) = NULL,
  @ConstMiddleName	NVARCHAR(50) = NULL,
  @PatientGUID			NVARCHAR(50) = NULL,
  @DOB					NVARCHAR(40) = NULL,
  @Height				NVARCHAR(10) = NULL,
  @Weight				NVARCHAR(10) = NULL,
  @BSA					NVARCHAR(10) = NULL
  )
AS
BEGIN
	
		update int_person_name 
			set last_nm = @LastName, 
				first_nm = @FirstName, 
				middle_nm = @MiddleName, 
				mpi_lname_cons =  @ConstLastName, 
				mpi_fname_cons = @ConstFirstName, 
				mpi_mname_cons = @ConstMiddleName
			where person_nm_id = @PatientGUID
			
		update int_person 
			set last_nm = @LastName, 
				first_nm = @FirstName, 
				middle_nm = @MiddleName 
			where person_id = @PatientGUID
			
			
		update int_patient 
			set dob = @DOB, 
				height = @Height, 
				weight = @Weight, bsa = @BSA  
		    where patient_id = @PatientGUID
End

