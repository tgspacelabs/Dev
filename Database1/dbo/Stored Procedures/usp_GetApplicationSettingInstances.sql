

--====================================================================================================================
--=================================================usp_GetApplicationSettingInstances==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Stored procedure for retrieving all Instance Ids for a given 
-- ApplicationSettings Application Type
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_GetApplicationSettingInstances]
    @applicationType VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT DISTINCT
        [InstanceId]
    FROM
        [dbo].[ApplicationSettings]
    WHERE
        [ApplicationType] = @applicationType; 
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetApplicationSettingInstances';

