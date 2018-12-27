
-- [UpdatePerson_Dm3] is used to Add or Update Encounter Table values in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_UpdatePerson]
    (
     @LastName NVARCHAR(50) = NULL,
     @FirstName NVARCHAR(50) = NULL,
     @MiddleName NVARCHAR(50) = NULL,
     @ConstLastName NVARCHAR(50) = NULL,
     @ConstFirstName NVARCHAR(50) = NULL,
     @ConstMiddleName NVARCHAR(50) = NULL,
     @PatientGUID NVARCHAR(50) = NULL,
     @DOB NVARCHAR(40) = NULL,
     @Height NVARCHAR(10) = NULL,
     @Weight NVARCHAR(10) = NULL,
     @BSA NVARCHAR(10) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_person_name]
    SET
        [last_nm] = @LastName,
        [first_nm] = @FirstName,
        [middle_nm] = @MiddleName,
        [mpi_lname_cons] = @ConstLastName,
        [mpi_fname_cons] = @ConstFirstName,
        [mpi_mname_cons] = @ConstMiddleName
    WHERE
        [person_nm_id] = @PatientGUID;
			
    UPDATE
        [dbo].[int_person]
    SET
        [last_nm] = @LastName,
        [first_nm] = @FirstName,
        [middle_nm] = @MiddleName
    WHERE
        [person_id] = @PatientGUID;
			
			
    UPDATE
        [dbo].[int_patient]
    SET
        [dob] = @DOB,
        [height] = @Height,
        [weight] = @Weight,
        [bsa] = @BSA
    WHERE
        [patient_id] = @PatientGUID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Add or Update Encounter Table values in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdatePerson';

