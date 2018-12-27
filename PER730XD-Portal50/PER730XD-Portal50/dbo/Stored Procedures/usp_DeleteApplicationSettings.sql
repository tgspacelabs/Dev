
--====================================================================================================================
--=================================================usp_DeleteApplicationSettings==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Stored procedure for removing all application settings for a 
-- specific ApplicationType and optionally filtered by instanceId and/or key. If instanceId
-- is specified then only application settings for that specific instanceId will be
-- deleted.
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_DeleteApplicationSettings]
    @applicationType varchar(50), 
    @instanceId varchar(50) = '%', -- by default delete all
    @key varchar(50) = '%' -- by default delete all
AS 
    SET NOCOUNT ON;
    
DELETE
FROM [dbo].[ApplicationSettings]
WHERE [ApplicationType]=@applicationType 
      AND [InstanceId] LIKE @instanceId
      AND [Key] LIKE @key


