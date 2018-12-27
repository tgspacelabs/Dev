

CREATE PROCEDURE [dbo].[usp_DM3_AddPatient]
    (
     @PatientGUID NVARCHAR(50),
     @DOB NVARCHAR(50) = NULL,
     @Height NVARCHAR(50) = NULL,
     @Weight NVARCHAR(50) = NULL,
     @BSA NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF (@DOB = 'NULL')
    BEGIN
        SET @DOB = NULL;
    END;
    INSERT  INTO [dbo].[int_patient]
            ([patient_id],
             [new_patient_id],
             [dob],
             [gender_cid],
             [height],
             [weight],
             [bsa]
            )
    VALUES
            (@PatientGUID,
             NULL,
             @DOB,
             NULL,
             @Height,
             @Weight,
             @BSA
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_AddPatient';

