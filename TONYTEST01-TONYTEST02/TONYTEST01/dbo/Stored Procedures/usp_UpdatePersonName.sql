create proc [dbo].[usp_UpdatePersonName]
(
@last_nm NVARCHAR(50),
@first_nm NVARCHAR(50),
@middle_nm NVARCHAR(50),
@person_nm_id  UNIQUEIDENTIFIER
)
as
begin
	 UPDATE 
                                                    int_person_name 
                                                    SET 
                                                    last_nm = @last_nm,
                                                    first_nm =@first_nm,
                                                    middle_nm = @middle_nm
                                                    WHERE 
                                                    person_nm_id =@person_nm_id 
                                                    AND 
                                                    active_sw = 1
end
