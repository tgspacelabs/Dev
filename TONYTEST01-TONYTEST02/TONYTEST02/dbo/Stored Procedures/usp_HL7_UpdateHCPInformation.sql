
CREATE PROCEDURE [dbo].[usp_HL7_UpdateHCPInformation]
(
	@hcpId UNIQUEIDENTIFIER,
	@LastNm NVARCHAR(100)=null,
	@FirstNm NVARCHAR(100)=null,
	@MiddleNm NVARCHAR(100)=null,
	@Degree NVARCHAR(40)=null
)
AS
BEGIN
	UPDATE int_hcp 
	SET
	last_nm=@LastNm,
	first_nm=@FirstNm,
	middle_nm=@MiddleNm,
	degree=@Degree
	
	WHERE hcp_id=@HcpId
END

