
-- =============================================
-- Author:		Syam
-- Create date: May - 22 - 2014
-- Description:	Retrieves the patient settings
-- =============================================

CREATE PROCEDURE [dbo].[usp_CA_GetPatientSettings]
  (
  @patient_id AS UNIQUEIDENTIFIER,
  @unit_id    AS UNIQUEIDENTIFIER 
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
             FROM   dbo.CfgValuesPatient
             WHERE  patient_id = @patient_id  )
      BEGIN
        DECLARE @TEMP TABLE(
          table_name    VARCHAR(25),
          type_cd       VARCHAR(25),
          cfg_name      VARCHAR( 40 ),
          cfg_value     DCFG_VALUES,
          cfg_xml_value XML,
          value_type    VARCHAR( 20 ))
        DECLARE
          @PAT_TABLE     VARCHAR(25),
          @UNIT_TABLE    VARCHAR(25),
          @FACTORY_TABLE VARCHAR(25),
          @GLOBAL_TABLE  VARCHAR(25)

        SET @PAT_TABLE = 'CfgValuesPatient'
        SET @UNIT_TABLE = 'CfgValuesUnit'
        SET @FACTORY_TABLE = 'CfgValuesFactory'
        SET @GLOBAL_TABLE = 'CfgValuesGlobal'

        INSERT INTO @TEMP
          SELECT @UNIT_TABLE,
                 type_cd,
                 cfg_name,
                 cfg_value,
                 cfg_xml_value,
                 value_type
          FROM   dbo.CfgValuesUnit
          WHERE  unit_id = @unit_id 

        INSERT INTO @TEMP
          SELECT @FACTORY_TABLE,
                 type_cd,
                 cfg_name,
                 cfg_value,
                 cfg_xml_value,
                 value_type
          FROM   dbo.CfgValuesFactory
          WHERE  global_type = 'false' 

        INSERT INTO @TEMP
          SELECT @GLOBAL_TABLE,
                 type_cd,
                 cfg_name,
                 cfg_value,
                 cfg_xml_value,
                 value_type
          FROM   dbo.CfgValuesGlobal
          WHERE  global_type = 'false' 

        DECLARE @CURRENT VARCHAR(25)

        SET @CURRENT = @UNIT_TABLE

        IF NOT EXISTS
               ( SELECT type_cd,
                        cfg_name,
                        cfg_value,
                        cfg_xml_value,
                        value_type
                 FROM   @TEMP
                 WHERE  table_name = @UNIT_TABLE )
          BEGIN
            SET @CURRENT = @GLOBAL_TABLE

            IF NOT EXISTS
                   ( SELECT type_cd,
                            cfg_name,
                            cfg_value,
                            cfg_xml_value,
                            value_type
                     FROM   @TEMP
                     WHERE  table_name = @GLOBAL_TABLE )
              SET @CURRENT = @FACTORY_TABLE
          END

        IF NOT EXISTS
               ( SELECT
						type_cd AS CFGTYPE,
						cfg_name AS CFGNAME,
						cfg_value AS CFGVALUE,
                        cfg_xml_value AS CFGXMLVALUE,
                        value_type AS VALUETYPE
                 FROM   dbo.CfgValuesPatient
                 WHERE  patient_id = @patient_id )
          BEGIN
            INSERT INTO CfgValuesPatient
              SELECT @patient_id,
                     type_cd,
                     cfg_name,
                     cfg_value,
                     cfg_xml_value,
                     value_type,
                     GETDATE( )
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
    FROM   dbo.CfgValuesPatient
    WHERE  patient_id = @patient_id 

  END


