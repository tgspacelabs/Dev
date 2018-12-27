

CREATE PROCEDURE [dbo].[GetPatientData]
  (
  @PatientID DPATIENT_ID
  )
AS
  BEGIN
	SELECT
    ISNULL(int_person.last_nm,'') + ISNULL(', ' + int_person.first_nm,'') AS PATIENT_NAME, 
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
        WHEN int_encounter.discharge_dt IS NULL 
      THEN 'A'
          ELSE 'D'
    END,
	[PRECEDENCE] = int_patient_monitor.last_result_dt
FROM 
    int_mrn_map
        INNER JOIN int_patient ON int_patient.patient_id = int_mrn_map.patient_id
        INNER JOIN int_person ON int_person.person_id = int_mrn_map.patient_id
        INNER JOIN int_encounter ON int_encounter.patient_id = int_mrn_map.patient_id
		INNER JOIN int_patient_monitor ON (int_encounter.encounter_id = int_patient_monitor.encounter_id)   
        INNER JOIN int_monitor ON (int_patient_monitor.monitor_id = int_monitor.monitor_id)         		
		INNER JOIN int_organization  AS CHILD  ON (int_monitor.unit_org_id = CHILD.organization_id)	
		LEFT OUTER JOIN int_organization AS PARENT ON PARENT.organization_id = CHILD.parent_organization_id
WHERE
    (int_mrn_map.patient_id = @PatientID) AND  (int_mrn_map.merge_cd = 'C')  

UNION 
	 SELECT										
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
		[STATUS],
		[PRECEDENCE] = [ADMIT_TIME]
	    FROM [dbo].[v_StitchedPatients] WHERE [PATIENT_ID]=@PatientID 
		
        ORDER BY PRECEDENCE DESC 
  END


