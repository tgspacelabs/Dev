
CREATE PROCEDURE [dbo].[GetqryLivePatientVitals]
  (
  @patient_id AS UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT DISTINCT
           VL.patient_id PATID,
           VL.Monitor_Id MONITORID,
           VL.collect_dt COLLECTDATE,
           VL.vital_value VITALS,
           VL.vital_time VITALSTIME,
           MRNMAP.Organization_Id ORGID,
           MRNMAP.mrn_xid MRN
    FROM   int_vital_live_temp VL,
           int_mrn_map MRNMAP,
           int_patient_monitor PM
    WHERE  ( @patient_id = '00000000-0000-0000-0000-000000000000'  OR VL.patient_id = @patient_id ) AND VL.patient_id = MRNMAP.patient_id AND merge_cd = 'C' AND PM.patient_id = VL.Patient_ID AND PM.monitor_id = VL.monitor_id AND VL.createdDT =
               ( SELECT Max( createdDT )
                 FROM   int_vital_live_temp AS VL_SUBTAB
                 WHERE  VL_SUBTAB.monitor_id = VL.monitor_id AND VL_SUBTAB.patient_id = VL.patient_id AND createdDT > ( GetDate( ) - 0.002 ) )

  END

