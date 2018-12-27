CREATE PROCEDURE [dbo].[usp_UpdateEncounter]
(
@unit_org_id UNIQUEIDENTIFIER, 
@organization_id UNIQUEIDENTIFIER, 
@rm NVARCHAR(6),
@bed NVARCHAR(6),
@patient_id UNIQUEIDENTIFIER
)
as
begin
	UPDATE 
                                                    int_encounter 
                                                    SET  
                                                    unit_org_id = @unit_org_id , 
                                                    organization_id = @organization_id, 
                                                    rm = @rm, 
                                                    bed = @bed
                                                    WHERE
                                                    status_cd ='C' 
                                                        AND 
                                                    patient_id =@patient_id
end

