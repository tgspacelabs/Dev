CREATE PROCEDURE [dbo].[usp_DM3_DeleteVitals]
 (
	@COLLECTDATE	NVARCHAR(30)
	)
AS
 BEGIN
 delete int_vital_live where collect_dt < @COLLECTDATE
 END
