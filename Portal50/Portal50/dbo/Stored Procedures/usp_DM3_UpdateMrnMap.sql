 
 CREATE PROCEDURE [dbo].[usp_DM3_UpdateMrnMap]
 (
	@PatientGUID	NVARCHAR(50),
	@MainOrgID		NVARCHAR(50)=null
	)
AS
 BEGIN
 update int_mrn_map 
        set adt_adm_sw = NULL 
        where patient_id = @PatientGUID 
        AND organization_id = @MainOrgID

 END
