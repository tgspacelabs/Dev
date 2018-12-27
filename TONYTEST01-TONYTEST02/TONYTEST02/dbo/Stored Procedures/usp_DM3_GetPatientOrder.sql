CREATE PROCEDURE [dbo].[usp_DM3_GetPatientOrder]
    (
	@EncounterGUID	NVARCHAR(50),
	@Result_USID		NVARCHAR(50)=null
	)
AS
 BEGIN
	 select * from int_order 
			  where encounter_id = @EncounterGUID 
			  and univ_svc_cid = @Result_USID
 END
 

