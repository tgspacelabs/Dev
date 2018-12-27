
CREATE PROCEDURE [dbo].[usp_DM3_AddPatient]
  (        
    @PatientGUID    NVARCHAR(50),
    @DOB            NVARCHAR(50) = NULL, 
    @Height            NVARCHAR(50) = NULL,
    @Weight            NVARCHAR(50) = NULL,
    @BSA            NVARCHAR(50) = NULL
    )
AS
 BEGIN
        if (@DOB = 'NULL')
        begin
            set @DOB = NULL
            end
        insert into int_patient (patient_id, 
                        new_patient_id, 
                        dob, 
                        gender_cid, 
                        height, 
                        weight, 
                        bsa)  
        values (@PatientGUID,NULL, @DOB,NULL,@Height,@Weight,@BSA)
    
 END
