
CREATE PROCEDURE [dbo].[PurgerwaveformParameters]
(
@purgeDate DateTime OUTPUT,
@ChunkSize INT OUTPUT
)
AS
Begin
	DECLARE @NumberOfHours int=NULL
	
	SET @NumberOfHours=CONVERT(INT,(SELECT setting FROM int_sysgen WHERE  product_cd = 'fulldiscl' AND feature_cd = 'NUMBER_OF_HOURS'),111)
	IF (@NumberOfHours IS NULL)
BEGIN
		SELECT @purgeDate = DATEADD(hh, -24, GETDATE())  --Default is 24 hrs
END
	ELSE
BEGIN
		SELECT @purgeDate = DATEADD(hh, -@NumberOfHours, GETDATE())  
END

	SET @ChunkSize=200--Default Chunk size is 200
	IF ((SELECT parm_value  FROM  int_system_parameter WHERE  active_flag = 1 and name='ChunkSize') IS NOT NULL)
	SELECT  @ChunkSize= parm_value  FROM  int_system_parameter WHERE  active_flag = 1 and name='ChunkSize'
END

