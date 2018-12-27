

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
    @applicationType VARCHAR(50),
    @instanceId VARCHAR(50) = '%', -- by default return all
    @key VARCHAR(50) = '%' -- by default return all
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT
        [ApplicationType],
        [InstanceId],
        [Key],
        [Value]
    FROM
        [dbo].[ApplicationSettings]
    WHERE
        [ApplicationType] = @applicationType
        AND [InstanceId] LIKE @instanceId
        AND [Key] LIKE @key
    ORDER BY
        [InstanceId];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Stored procedure for retrieving all application settings for a specific ApplicationType and optionally filtered by instanceId and/or key.  If instanceId is specified then only application settings for that specific instanceId will be returned.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetApplicationSettings';

