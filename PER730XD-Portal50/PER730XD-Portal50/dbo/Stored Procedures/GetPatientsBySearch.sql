
/****** Object:  StoredProcedure [dbo].[GetPatientsBySearch]    Script Date: 01/15/2015 11:41:52 ******/
CREATE PROCEDURE [dbo].[GetPatientsBySearch]
  (
  @last_name                     DLAST_NAME,
  @first_name                    DFIRST_NAME,
  @mrn_id                        DMRN_ID,
  @login_name                    NVARCHAR(64),
  @is_vip_searchable             NVARCHAR(4),
  @is_restricted_unit_searchable NVARCHAR(4)
  )
AS
  BEGIN
    DECLARE
      @QUERY     VARCHAR(4000),
      @CONDITION VARCHAR(1000)

    SET @QUERY ='
SELECT 
    int_mrn_map.patient_id AS PATIENT_ID, 
    ISNULL(int_person.last_nm,'''') + ISNULL('', '' + int_person.first_nm,'''') AS PATIENT_NAME, 
    int_monitor.monitor_name AS MONITOR_NAME,
    int_mrn_map.mrn_xid2 AS ACCOUNT_ID,
    int_mrn_map.mrn_xid AS MRN_ID,
    ORG1.organization_id AS UNIT_ID,
    ORG1.organization_cd AS UNIT_NAME,
    ORG2.organization_id AS FACILITY_ID,
    ORG2.organization_nm AS FACILITY_NAME,
    int_patient.dob AS DOB,
    int_encounter.admit_dt AS ADMIT_TIME,
    int_encounter.discharge_dt AS DISCHARGED_TIME,
    int_patient_monitor.last_result_dt AS PRECEDENCE,
    int_patient_monitor.patient_monitor_id AS PATIENT_MONITOR_ID,
    STATUS = case  
        WHEN int_encounter.discharge_dt IS NULL 
      THEN ''A''
          ELSE ''D''
    END
FROM
    int_patient_monitor
    INNER JOIN int_encounter ON int_encounter.encounter_id = int_patient_monitor.encounter_id 
    INNER JOIN int_monitor ON int_patient_monitor.monitor_id = int_monitor.monitor_id 
    INNER JOIN int_organization  AS ORG1 ON (int_monitor.unit_org_id = ORG1.organization_id)                                
    INNER JOIN int_mrn_map ON int_encounter.patient_id = int_mrn_map.patient_id AND int_mrn_map.merge_cd = ''C''
    INNER JOIN int_person ON int_encounter.patient_id = int_person.person_id 
    INNER JOIN int_patient ON int_encounter.patient_id = int_patient.patient_id
    LEFT OUTER JOIN int_account ON int_encounter.account_id = int_account.account_id 
    LEFT OUTER JOIN int_organization AS ORG2 ON ORG2.organization_id=ORG1.parent_organization_id
 '

    --convert * to percentile in variables
    SET @last_name = LTRIM(RTRIM(@last_name))

    SET @first_name = LTRIM(RTRIM(@first_name))

    SET @mrn_id = LTRIM(RTRIM(@mrn_id))

    SET @CONDITION = ISNULL(@CONDITION, '')

    --Unit accessibility
    IF( @is_restricted_unit_searchable <> '1' )
      BEGIN
        SET @CONDITION = @CONDITION + ' ORG1.organization_id 
                    NOT IN (SELECT cdr_restricted_organization.organization_id FROM cdr_restricted_organization
                    WHERE (cdr_restricted_organization.user_role_id = 
                    (SELECT user_role_id FROM int_user WHERE login_name =''' + @login_name + ''')))'
      END

    --Last name
    IF ( len( @last_name ) > 0 )
      BEGIN
       
        SET @last_name = Replace( @last_name,
                                  '*',
                                  '%' )
        SET @last_name=  QuoteName(@last_name,'''')

        IF( len( @CONDITION ) > 0 )
          SET @CONDITION = @CONDITION + ' AND '

        SET @CONDITION = @CONDITION + ' (int_person.last_nm like ' + @last_name + ')'
      END

    --First name
    IF ( len( @first_name ) > 0 )
      BEGIN
       
        SET @first_name = Replace( @first_name,
                                   '*',
                                   '%' )
        SET @first_name=  QuoteName(@first_name,'''')

        IF( len( @CONDITION ) > 0 )
          SET @CONDITION = @CONDITION + ' AND '

        SET @CONDITION = @CONDITION + ' (int_person.first_nm like ' + @first_name + ')'
      END

  /*
  if (LEN(@patient_id) > 0)
  BEGIN
    SET @patient_id = REPLACE(@patient_id, '*', '%')
    if(LEN(@CONDITION) > 0)
        SET @CONDITION = @CONDITION + ' AND '
    SET @CONDITION = @CONDITION +' (int_patient.patient_id like ''' + @patient_id+''')'
  END */
    --MRN ID
    IF ( len( @mrn_id ) > 0 )
      BEGIN
       
        SET @mrn_id=  QuoteName(@mrn_id,'''')
        
        SET @mrn_id = REPLACE( @mrn_id, '\', '\\')
        SET @mrn_id = REPLACE( @mrn_id, '[', '\[')
        SET @mrn_id = REPLACE( @mrn_id, ']', '\]')
        SET @mrn_id = REPLACE( @mrn_id, '_', '\_')
        SET @mrn_id = REPLACE( @mrn_id, '%', '\%')
        SET @mrn_id = REPLACE( @mrn_id, '^', '\^')
        SET @mrn_id = Replace( @mrn_id, '*', '%' )

        IF( len( @CONDITION ) > 0 )
          SET @CONDITION = @CONDITION + ' AND '

        SET @CONDITION = @CONDITION + ' (int_mrn_map.mrn_xid like ' + @mrn_id + ' ESCAPE ''\'')'
      END

    --Check for VIP Patient
    IF( @is_vip_searchable <> '1' )
      BEGIN
        IF( len( @CONDITION ) > 0 )
          BEGIN
            SET @CONDITION = @CONDITION + ' AND '
          END

        SET @CONDITION = @CONDITION + 'int_encounter.vip_sw IS NULL'
      END

    --Add condition
    IF( len( @CONDITION ) > 0 )
      BEGIN
        SET @QUERY = @QUERY + ' WHERE '
        SET @QUERY = @QUERY + @CONDITION
      END

-- Add a separate query for dataloader patients

    SET @QUERY = @QUERY + '

UNION

SELECT 
    [PATIENT_ID], 
    [PATIENT_NAME], 
    [MONITOR_NAME],
    [ACCOUNT_ID],
    [MRN_ID],
    [UNIT_ID],
    [UNIT_NAME],
    [FACILITY_ID],
    [FACILITY_NAME],
    [DOB],
    [ADMIT_TIME],
    [DISCHARGED_TIME],
    [ADMIT_TIME] AS [PRECEDENCE],
    [PATIENT_MONITOR_ID],
    [STATUS]
FROM [dbo].[v_StitchedPatients]
 '

    SET @CONDITION = ''

     --Unit accessibility
    IF( @is_restricted_unit_searchable <> '1' )
      BEGIN
        SET @CONDITION = @CONDITION + ' [UNIT_ID] 
                    NOT IN (SELECT cdr_restricted_organization.organization_id FROM cdr_restricted_organization
                    WHERE (cdr_restricted_organization.user_role_id = 
                    (SELECT user_role_id FROM int_user WHERE login_name =''' + @login_name + ''')))'
      END

    --Last name
    IF ( len( @last_name ) > 0 )
      BEGIN
    
        IF( len( @CONDITION ) > 0 )
          SET @CONDITION = @CONDITION + ' AND '

        SET @CONDITION = @CONDITION + ' (LTRIM(RTRIM([LAST_NAME])) like ' + @last_name + ')'
      END

    --First name
    IF ( len( @first_name ) > 0 )
      BEGIN

        IF( len( @CONDITION ) > 0 )
          SET @CONDITION = @CONDITION + ' AND '

        SET @CONDITION = @CONDITION + ' (LTRIM(RTRIM([FIRST_NAME])) like ' + @first_name + ')'
      END

    --MRN ID
    IF ( len( @mrn_id ) > 0 )
      BEGIN

        IF( len( @CONDITION ) > 0 )
          SET @CONDITION = @CONDITION + ' AND '

        SET @CONDITION = @CONDITION + ' (LTRIM(RTRIM([MRN_ID])) like ' + @mrn_id + ' ESCAPE ''\'')'
      END

    --Add condition
    IF( len( @CONDITION ) > 0 )
      BEGIN
        SET @QUERY = @QUERY + ' WHERE PATIENT_ID IS NOT NULL AND '
        SET @QUERY = @QUERY + @CONDITION
      END

    SET @QUERY = @QUERY + '
ORDER BY 
    [STATUS],
    [ADMIT_TIME] DESC, 
    [PATIENT_NAME],
    [PRECEDENCE] DESC,
    [MONITOR_NAME]'

    EXEC (@QUERY)
  END
