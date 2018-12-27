
--====================================================================================================================
--=================================================usp_GetApplicationSettingInstances==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Stored procedure for retrieving all Instance Ids for a given 
-- ApplicationSettings Application Type
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_GetApplicationSettingInstances]
    @applicationType varchar(50)
AS 
    SET NOCOUNT ON;
    
SELECT distinct [InstanceId]
FROM [dbo].[ApplicationSettings]
WHERE [ApplicationType]=@applicationType 


