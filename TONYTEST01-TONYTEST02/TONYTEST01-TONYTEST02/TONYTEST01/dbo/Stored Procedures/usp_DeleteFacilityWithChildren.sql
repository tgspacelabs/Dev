create proc [dbo].[usp_DeleteFacilityWithChildren]

as
begin
	DELETE 
                                                            FROM 
                                                            int_organization  
                                                            WHERE 
                                                            parent_organization_id 
                                                            IS NOT NULL 
                                                            AND 
                                                            parent_organization_id 
                                                            NOT IN 
                                                            (
                                                            SELECT 
                                                            organization_id 
                                                            FROM 
                                                            int_organization
                                                            )
end
