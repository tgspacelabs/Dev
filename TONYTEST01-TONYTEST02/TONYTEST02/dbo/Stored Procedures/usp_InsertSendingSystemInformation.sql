
/*usp_InsertSendingSystemInformation- Used to insert the sending system details*/
CREATE PROCEDURE [dbo].[usp_InsertSendingSystemInformation]
(
@SysId UNIQUEIDENTIFIER,
@OrganizationId UNIQUEIDENTIFIER,
@code NVARCHAR(180),
@dsc NVARCHAR(180)
)
AS
BEGIN
INSERT INTO int_send_sys
(
	sys_id,
	organization_id,
	code,
	dsc
)
VALUES
(
	@SysId,
	@OrganizationId,
	@code,
	@dsc
)
END

