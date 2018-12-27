
CREATE PROCEDURE [dbo].[UpdatexmlValue]
  (
  @type_cd  VARCHAR(25),
  @cfg_name VARCHAR(40),
  @isGlobal VARCHAR(10),
  @Filename VARCHAR(100)
  )
AS
  BEGIN
    IF EXISTS
       ( SELECT *
         FROM   CfgValuesFactory
         WHERE  type_cd = @type_cd AND cfg_name = @cfg_name )
      DELETE CfgValuesFactory
      WHERE  type_cd = @type_cd AND cfg_name = @cfg_name

    IF EXISTS
       ( SELECT *
         FROM   CfgValuesGlobal
         WHERE  type_cd = @type_cd AND cfg_name = @cfg_name )
      DELETE CfgValuesGlobal
      WHERE  type_cd = @type_cd AND cfg_name = @cfg_name

    IF EXISTS
       ( SELECT *
         FROM   CfgValuesUnit
         WHERE  type_cd = @type_cd AND cfg_name = @cfg_name )
      DELETE CfgValuesUnit
      WHERE  type_cd = @type_cd AND cfg_name = @cfg_name

    IF EXISTS
       ( SELECT *
         FROM   cfgValuesPatient
         WHERE  type_cd = @type_cd AND cfg_name = @cfg_name )
      DELETE cfgValuesPatient
      WHERE  type_cd = @type_cd AND cfg_name = @cfg_name

    DECLARE @SQL VARCHAR(1000)

    SET @SQL = "INSERT INTO cfgValuesFactory
               (type_cd
               ,cfg_name
               ,cfg_value
               ,value_type
               ,global_type
               ,cfg_xml_value          
               )
    select '" + @type_cd + "' AS type_cd, '" + @cfg_name + "' AS cfg_name,
    null AS cfg_value,
    'xml' AS value_type, '" + @isGlobal + "' AS global_type,
    BulkColumn from openrowset(bulk '" + @Filename + "', single_blob) AS cfg_xml_value"

    EXEC (@SQL)
  END

