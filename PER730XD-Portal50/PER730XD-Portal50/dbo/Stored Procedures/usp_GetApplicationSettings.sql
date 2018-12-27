
--====================================================================================================================
--=================================================usp_GetApplicationSettings==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Stored procedure for retrieving all application settings for a 
-- specific ApplicationType and optionally filtered by instanceId and/or key. If instanceId
-- is specified then only application settings for that specific instanceId will be
-- returned.
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_GetApplicationSettings]
    @applicationType varchar(50), 
    @instanceId varchar(50) = '%', -- by default return all
    @key varchar(50) = '%' -- by default return all
AS 
    SET NOCOUNT ON;
    
SELECT *
FROM [dbo].[ApplicationSettings]
WHERE [ApplicationType]=@applicationType 
      AND [InstanceId] LIKE @instanceId
      AND [Key] LIKE @key
ORDER BY [InstanceId]

