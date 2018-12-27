 CREATE PROCEDURE [dbo].[usp_DM3_GetGatewayDetails]
 (
	@NetworkID	NVARCHAR(30)
	)
AS
 BEGIN
select * from int_gateway where network_id = @NetworkID
 END
