CREATE PROCEDURE [dbo].[usp_CheckCodeUnique]
(
@value NVARCHAR(20),
@orgID UNIQUEIDENTIFIER,
@parentID UNIQUEIDENTIFIER
)
as
begin
	SELECT 
                                                COUNT(*) AS TotalCount
                                                FROM
                                                int_organization 
                                                WHERE 
                                                organization_cd = @value
                                                AND 
                                                organization_id <> @orgID 
                                                AND
                                                parent_organization_id = @parentID
end

