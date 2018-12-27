create proc [dbo].[usp_IsVIPPatient]
(
@mrn_xid NVARCHAR(30)
)
as
begin
	SELECT 
		ENC.vip_sw 
		from 
		int_encounter 
		AS 
		ENC  
		INNER JOIN 
		int_mrn_map 
		AS MRNMAP 
		ON 
		MRNMAP.patient_id = ENC.patient_id 
			WHERE 
			MRNMAP.mrn_xid = @mrn_xid
end
