
/*[SP_RetrieveConfigurationSection] is used to retrieve Configuration data */
CREATE PROCEDURE [dbo].[usp_RetrieveConfigurationSection] (@ApplicationName NVARCHAR(256), @SectionName NVARCHAR(256))
AS
BEGIN
	SELECT SectionData,
	UpdatedTimeStampUTC
	FROM   tbl_ConfigurationData
	WHERE  ApplicationName = @ApplicationName AND    SectionName = @SectionName
END
	
