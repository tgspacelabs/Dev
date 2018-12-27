

-- =============================================
-- Author:		Syam
-- Create date: May - 22 - 2014
-- Description:	Retrieves the unit settings
-- =============================================


CREATE PROCEDURE [dbo].[usp_CA_GetUnitSettings]
  (
  @unit_id  AS UNIQUEIDENTIFIER  
  )
AS
  BEGIN
    DECLARE
      @RC     INT,
      @RESULT INT

    SET @RESULT = 0

    IF NOT EXISTS
           ( SELECT
					type_cd AS CFGTYPE,
					cfg_name AS CFGNAME,
					cfg_value AS CFGVALUE,
                    cfg_xml_value AS CFGXMLVALUE,
                    value_type AS VALUETYPE                    
             FROM   dbo.CfgValuesUnit
             WHERE  unit_id = @unit_id )
      BEGIN
        DECLARE @TEMP TABLE(
          table_name    VARCHAR(25),
          type_cd       VARCHAR(25),
          cfg_name      VARCHAR(40),
          cfg_value     DCFG_VALUES,
          cfg_xml_value XML,
          value_type    VARCHAR(20));

        DECLARE
          @UNIT_TABLE    VARCHAR(25),
          @GLOBAL_TABLE  VARCHAR(25),
          @FACTORY_TABLE VARCHAR(25)

        SET @UNIT_TABLE = 'CfgValuesUnit'
        SET @GLOBAL_TABLE = 'CfgValuesGlobal'
        SET @FACTORY_TABLE = 'CfgValuesFactory'

        INSERT INTO @TEMP
          SELECT @GLOBAL_TABLE,
                 type_cd,
                 cfg_name,
                 cfg_value,
                 cfg_xml_value,
                 value_type
          FROM   dbo.CfgValuesGlobal
          WHERE  global_type = 'false'

        INSERT INTO @TEMP
          SELECT @FACTORY_TABLE,
                 type_cd,
                 cfg_name,
                 cfg_value,
                 cfg_xml_value,
                 value_type
          FROM   dbo.CfgValuesFactory
          WHERE  global_type = 'false'

        DECLARE @CURRENT VARCHAR(25)

        SET @CURRENT = @GLOBAL_TABLE

        IF NOT EXISTS
               ( SELECT type_cd,
                        cfg_name,
                        cfg_value,
                        cfg_xml_value,
                        value_type
                 FROM   @TEMP
                 WHERE  table_name = @GLOBAL_TABLE)
          BEGIN
            SET @CURRENT = @FACTORY_TABLE
          END

        IF NOT EXISTS
               ( SELECT 
						type_cd AS CFGTYPE,
						cfg_name AS CFGNAME,
						cfg_value AS CFGVALUE,
                        cfg_xml_value AS CFGXMLVALUE,
                        value_type AS VALUETYPE
                 FROM   dbo.CfgValuesUnit
                 WHERE  unit_id = @unit_id)
          BEGIN
            INSERT INTO CfgValuesUnit
              SELECT @unit_id,
                     type_cd,
                     cfg_name,
                     cfg_value,
                     cfg_xml_value,
                     value_type
              FROM   @TEMP
              WHERE  table_name = @CURRENT

          END
      END

    SELECT 
		   type_cd AS CFGTYPE,
		   cfg_name AS CFGNAME,
		   cfg_value AS CFGVALUE,
           cfg_xml_value AS CFGXMLVALUE,
           value_type AS VALUETYPE,
           CAST(0 AS BIT) AS GLOBALTYPE
    FROM   dbo.CfgValuesUnit
    WHERE  unit_id = @unit_id

  END
  

