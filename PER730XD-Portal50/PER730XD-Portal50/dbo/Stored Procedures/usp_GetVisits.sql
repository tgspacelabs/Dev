CREATE PROCEDURE [dbo].[usp_GetVisits]
  (
 @PatientID UNIQUEIDENTIFIER
  )
AS
  BEGIN
      SELECT int_encounter.admit_dt AS Admitted,
      int_encounter.discharge_dt AS Discharged,
      int_encounter.account_id AS 'Account Number', 
      (ISNULL(int_organization.organization_cd, '-') + ' ' + ISNULL(int_encounter.rm, '-') + ' ' + ISNULL(int_encounter.bed, '-')) AS Location, 
      int_encounter_map.encounter_xid AS 'Encounter Number',
      int_encounter.encounter_id AS GUID 
      FROM 
      int_encounter  
      INNER JOIN int_encounter_map 
      ON int_encounter.encounter_id = int_encounter_map.encounter_id 
      INNER JOIN int_organization 
      ON int_encounter.unit_org_id = int_organization.organization_id 
      WHERE int_encounter.patient_id =@PatientID 
      ORDER BY 1 DESC
  END
