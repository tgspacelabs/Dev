create proc [dbo].[usp_UpdatePatient]
(
@dob datetime, 
@gender_cid int,
@patient_id UNIQUEIDENTIFIER
)
as
begin
    UPDATE 
int_patient 
SET 
dob = @dob, 
gender_cid =@gender_cid 
WHERE
patient_id = @patient_id
end
