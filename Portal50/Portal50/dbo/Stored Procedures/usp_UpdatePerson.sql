create proc [dbo].[usp_UpdatePerson]
(
@last_nm NVARCHAR(50),
@first_nm NVARCHAR(50),
@middle_nm NVARCHAR(50),
@person_id UNIQUEIDENTIFIER
)
as
begin
	UPDATE 
                                                int_person 
                                                SET 
                                                last_nm =@last_nm,
                                                first_nm =@first_nm,
                                                middle_nm =@middle_nm 
                                                where 
                                                person_id =@person_id
end
