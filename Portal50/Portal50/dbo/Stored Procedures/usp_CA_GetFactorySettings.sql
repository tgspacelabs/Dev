

-- =============================================
-- Author:		Syam
-- Create date: May - 22 - 2014
-- Description:	Retrieves the factory settings
-- =============================================

CREATE PROCEDURE [dbo].[usp_CA_GetFactorySettings]
AS
  BEGIN
    SELECT
		   type_cd AS CFGTYPE,
		   cfg_name AS CFGNAME,
		   cfg_value AS CFGVALUE,
           cfg_xml_value AS CFGXMLVALUE,
           value_type AS VALUETYPE,
           global_type AS GLOBALTYPE
    FROM   dbo.CfgValuesFactory    
  END

