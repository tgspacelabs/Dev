

-- =============================================
-- Author:		Syam
-- Create date: May - 22 - 2014
-- Description:	Retrieves the global settings
-- =============================================
CREATE PROCEDURE [dbo].[usp_CA_GetGlobalSettings]  
AS
  BEGIN
    IF NOT EXISTS
           ( SELECT
					type_cd AS CFGTYPE,
					cfg_name AS CFGNAME,
					cfg_value AS CFGVALUE,
                    cfg_xml_value AS CFGXMLVALUE,
                    value_type AS VALUETYPE,
                    global_type AS GLOBALTYPE
             FROM   dbo.CfgValuesGlobal)
      BEGIN
        INSERT INTO CfgValuesGlobal
          SELECT type_cd,
                 cfg_name,
                 cfg_value,
                 cfg_xml_value,
                 value_type,
                 global_type
          FROM   dbo.CfgValuesFactory          
      END

    SELECT type_cd AS CFGTYPE,
		   cfg_name AS CFGNAME,
		   cfg_value AS CFGVALUE,
           cfg_xml_value AS CFGXMLVALUE,
           value_type AS VALUETYPE,
           global_type AS GLOBALTYPE
    FROM   dbo.CfgValuesGlobal    
  END


