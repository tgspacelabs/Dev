
/*[SP_SaveConfigurationSection] table is used to save Configuration data */
CREATE PROCEDURE [dbo].[usp_SaveConfigurationSection](@ApplicationName NVARCHAR(256), @SectionName NVARCHAR(256),@SectionData xml)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM tbl_ConfigurationData WHERE ApplicationName=@ApplicationName AND SectionName=@SectionName)
	BEGIN
		UPDATE [dbo].[tbl_ConfigurationData] SET SectionData=@SectionData,UpdatedTimeStampUTC=GETUTCDATE()
		WHERE ApplicationName=@ApplicationName AND SectionName=@SectionName;
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[tbl_ConfigurationData]
		(ApplicationName,SectionName,SectionData,UpdatedTimeStampUTC)
		VALUES
		(@ApplicationName,@SectionName,@SectionData,GETUTCDATE());
	END
END


