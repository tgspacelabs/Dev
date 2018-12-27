
CREATE PROCEDURE [dbo].[GetPatientByExternalID]
  (
  @patientExtID AS NVARCHAR(30)
  )
AS
  BEGIN
    SELECT int_mrn_map.patient_id AS PATIENT_ID,
           int_mrn_map.mrn_xid AS PATIENT_MRN,
           int_person.first_nm AS FIRST_NAME,
           int_person.last_nm AS LAST_NAME
    FROM   int_mrn_map
           INNER JOIN int_encounter
             ON int_encounter.patient_id = int_mrn_map.patient_id
           INNER JOIN int_person
             ON int_encounter.patient_id = int_person.person_id
           INNER JOIN int_patient
             ON int_encounter.patient_id = int_patient.patient_id
		   INNER JOIN int_patient_monitor on int_patient_monitor.encounter_id = int_encounter.encounter_id
			INNER JOIN int_monitor on int_monitor.monitor_id = int_patient_monitor.monitor_id

    WHERE   RTRIM(LTRIM(int_mrn_map.mrn_xid)) = RTRIM(LTRIM(@patientExtID)) AND int_mrn_map.merge_cd = 'C' -- first return patients matching ID1

UNION ALL 

	SELECT [PATIENT_ID],
		   [ID1] AS [PATIENT_MRN],
		   [FIRST_NAME],
		   [LAST_NAME]
	FROM [dbo].[v_Patients]
	WHERE [ID1]= @patientExtId -- first return patients matching ID1

UNION ALL

    SELECT int_mrn_map.patient_id AS PATIENT_ID,
           int_mrn_map.mrn_xid AS PATIENT_MRN,
           int_person.first_nm AS FIRST_NAME,
           int_person.last_nm AS LAST_NAME
    FROM   int_mrn_map
           INNER JOIN int_encounter
             ON int_encounter.patient_id = int_mrn_map.patient_id
           INNER JOIN int_person
             ON int_encounter.patient_id = int_person.person_id
           INNER JOIN int_patient
             ON int_encounter.patient_id = int_patient.patient_id
		   INNER JOIN int_patient_monitor on int_patient_monitor.encounter_id = int_encounter.encounter_id
			INNER JOIN int_monitor on int_monitor.monitor_id = int_patient_monitor.monitor_id
    WHERE  RTRIM(LTRIM(int_mrn_map.mrn_xid2)) = RTRIM(LTRIM(@patientExtID))  AND int_mrn_map.merge_cd = 'C' -- then return patients matching ID2

UNION ALL

	SELECT [PATIENT_ID],
		   [ID1] AS [PATIENT_MRN],
		   [FIRST_NAME],
		   [LAST_NAME]
	FROM [dbo].[v_Patients]
	WHERE [ID2] = @patientExtId -- then return patients matching ID2
END

