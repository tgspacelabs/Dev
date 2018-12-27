
--====================================================================================================================
--=================================================usp_UpdateApplicationSettingsInstanceId==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Updates an the instance Id for a group of application settings in the database
--
--@applicationType: The application type of the instance id to update
--@oldInstanceId: The instance Id to update
--@newInstanceId: The new instance Id to replace the old one with<
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_UpdateApplicationSettingsInstanceId]
	@applicationType VARCHAR(50),
	@oldInstanceId VARCHAR(50),
	@newInstanceId VARCHAR(50)
AS

UPDATE [dbo].[ApplicationSettings]
SET InstanceId = @newInstanceId
WHERE InstanceId = @oldInstanceId

