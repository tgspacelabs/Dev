CREATE PROCEDURE [dbo].[usp_UpdateMrn]
(
@mrn_xid NVARCHAR(30),
@mrn_xid2 NVARCHAR(30),
@patient_id UNIQUEIDENTIFIER
)
as
begin
	UPDATE 
                                                int_mrn_map 
                                                SEt  
                                                mrn_xid = @mrn_xid,
                                                mrn_xid2 = @mrn_xid2 
                                                WHERE 
                                                patient_id=@patient_id
end

