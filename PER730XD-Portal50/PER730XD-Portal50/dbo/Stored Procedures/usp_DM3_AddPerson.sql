
CREATE PROCEDURE [dbo].[usp_DM3_AddPerson]
  (
    @PatientGUID        NVARCHAR(50),
    @First_Name        NVARCHAR(50) = NULL,
    @Middle_Name    NVARCHAR(50) = NULL,
    @Last_Name        NVARCHAR(50) = NULL
    )
AS
BEGIN    
        insert into int_person (person_id, 
                        new_patient_id, 
                        first_nm, 
                        middle_nm, 
                        last_nm, 
                        suffix, 
                        tel_no, 
                        line1_dsc, 
                        line2_dsc, 
                        line3_dsc, 
                        city_nm, 
                        state_code, 
                        zip_code, 
                        country_cid)
        values (@PatientGUID,NULL,@First_Name,@Middle_Name,@Last_Name,NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL, NULL)
END
