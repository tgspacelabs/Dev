
CREATE PROCEDURE [dbo].[GetUserPatientsList]
  (
  @unit_id           DUNIT_ID,
  @status            NVARCHAR(40),
  @is_vip_searchable BIT='0'
  )
AS
  BEGIN
	DECLARE @QUERY VARCHAR(4000)

SET @QUERY = '(SELECT int_mrn_map.patient_id AS PATIENT_ID,
							ISNULL(int_person.last_nm,'''') + ISNULL('', '' + int_person.first_nm,'''') AS PATIENT_NAME,
							int_monitor.monitor_name AS MONITOR_NAME,
							int_mrn_map.mrn_xid2 AS ACCOUNT_ID,
							int_mrn_map.mrn_xid AS MRN_ID,
							int_monitor.unit_org_id AS UNIT_ID,
							CHILD.organization_cd AS UNIT_NAME,
							PARENT.organization_id AS FACILITY_ID,
							PARENT.organization_nm AS FACILITY_NAME,  
							int_patient.dob AS DOB,
							int_encounter.admit_dt AS ADMIT_TIME,
							int_encounter.discharge_dt AS DISCHARGED_TIME,
							int_patient_monitor.patient_monitor_id AS PATIENT_MONITOR_ID,
						STATUS = CASE
									WHEN int_encounter.discharge_dt IS NULL AND active_sw = 1 then ''A'' ELSE ''D''
								END
					FROM int_encounter
						LEFT OUTER JOIN dbo.int_patient_monitor ON (int_encounter.encounter_id = dbo.int_patient_monitor.encounter_id) AND
																	(int_encounter.patient_id = dbo.int_patient_monitor.patient_id)
						INNER JOIN int_person ON (int_encounter.patient_id = int_person.person_id)
						INNER JOIN int_patient ON (int_person.person_id = int_patient.patient_id)
						INNER JOIN int_mrn_map ON (int_patient.patient_id = int_mrn_map.patient_id)
						INNER JOIN int_monitor ON (dbo.int_patient_monitor.monitor_id = int_monitor.monitor_id)                       
						INNER JOIN int_organization  AS CHILD ON (int_monitor.unit_org_id = CHILD.organization_id)								
						LEFT OUTER JOIN int_organization AS PARENT ON PARENT.organization_id = CHILD.parent_organization_id										
					WHERE
						(int_monitor.unit_org_id ='
	SET @QUERY = @QUERY + ''''
	SET @QUERY = @QUERY + @unit_id
	SET @QUERY = @QUERY + ''''
	SET @QUERY = @QUERY + ') AND (int_mrn_map.merge_cd = ''C'') '

	IF( @STATUS = 'ACTIVE' )
		SET @QUERY = @QUERY + ' AND (int_encounter.discharge_dt IS NULL) and (int_patient_monitor.active_sw = 1) '

	IF( @STATUS = 'DISCHARGED' )
		SET @QUERY = @QUERY + ' AND (int_encounter.discharge_dt IS NOT NULL) '

	IF( @is_vip_searchable <> '1' )
		SET @QUERY = @QUERY + '  AND int_encounter.vip_sw IS NULL '

	SET @QUERY = @QUERY + ' ) UNION (SELECT
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
										[PATIENT_MONITOR_ID],
										[STATUS]
	                                 FROM [dbo].[v_StitchedPatients] WHERE '

	SET @QUERY = @QUERY + ' [UNIT_ID] = '''
	SET @QUERY = @QUERY + @unit_id
	SET @QUERY = @QUERY + ''''

	IF ( @STATUS = 'ACTIVE' )
		SET @QUERY = @QUERY + ' AND [STATUS] = ''A'' '

	IF ( @STATUS = 'DISCHARGED' )
		SET @QUERY = @QUERY + ' AND [STATUS] = ''D'' '

	SET @QUERY = @QUERY + ' AND [PATIENT_ID] IS NOT NULL '

	SET @QUERY = @QUERY + ') ORDER BY [ADMIT_TIME] DESC,
										[PATIENT_NAME],
										[MONITOR_NAME]'

    EXEC(@QUERY)
  END

