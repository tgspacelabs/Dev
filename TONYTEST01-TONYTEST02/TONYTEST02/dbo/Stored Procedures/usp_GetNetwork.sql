CREATE PROCEDURE [dbo].[usp_GetNetwork]

as
begin
	SELECT distinct network_id FROM int_monitor ORDER BY network_id
end

