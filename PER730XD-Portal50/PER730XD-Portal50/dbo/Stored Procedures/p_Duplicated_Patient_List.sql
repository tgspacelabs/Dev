
CREATE PROCEDURE [dbo].[p_Duplicated_Patient_List]
AS
  BEGIN
    SELECT dbo.ml_duplicate_info.duplicate_rec_id,
           dbo.ml_duplicate_info.Duplicate_Id AS MRN,
           dbo.int_mrn_map.patient_id
    INTO   #TMP1
    FROM   dbo.ml_duplicate_info
           INNER JOIN dbo.int_mrn_map
             ON ( dbo.ml_duplicate_info.Duplicate_Id = dbo.int_mrn_map.mrn_xid )
           INNER JOIN dbo.int_patient_monitor
             ON ( dbo.int_mrn_map.patient_id = dbo.int_patient_monitor.patient_id )
    WHERE  ( dbo.int_patient_monitor.active_sw = 1 )

    SELECT dbo.ml_duplicate_info.duplicate_rec_id,
           dbo.ml_duplicate_info.Original_Id AS MRN,
           dbo.int_mrn_map.patient_id
    INTO   #TMP2
    FROM   dbo.ml_duplicate_info
           INNER JOIN dbo.int_mrn_map
             ON ( dbo.ml_duplicate_info.Original_Id = dbo.int_mrn_map.mrn_xid )
           INNER JOIN dbo.int_patient_monitor
             ON ( dbo.int_mrn_map.patient_id = dbo.int_patient_monitor.patient_id )
    WHERE  ( dbo.int_patient_monitor.active_sw = 1 )

    SELECT DISTINCT
           MAP.patient_id AS PATID,
           MAP.mrn_xid
    FROM   dbo.int_mrn_map MAP
           INNER JOIN dbo.int_patient_monitor MON
             ON ( MAP.patient_id = MON.patient_id )
    WHERE  MAP.MRN_XID IN
           ( SELECT ORIGINAL_ID
             FROM   ML_DUPLICATE_INFO DUP
             WHERE  DUP.duplicate_rec_id IN
                    ( SELECT #tmp1.duplicate_rec_id
                      FROM   #TMP1
                             INNER JOIN #TMP2
                               ON ( #tmp1.duplicate_rec_id = #tmp2.duplicate_rec_id ) ) )  OR MAP.MRN_XID IN
               ( SELECT DUPLICATE_ID
                 FROM   ML_DUPLICATE_INFO DUP
                 WHERE  DUP.duplicate_rec_id IN
                        ( SELECT #tmp1.duplicate_rec_id
                          FROM   #TMP1
                                 INNER JOIN #TMP2
                                   ON ( #tmp1.duplicate_rec_id = #tmp2.duplicate_rec_id ) ) ) AND ( MON.Active_sw = 1 )

    DROP TABLE #TMP1

    DROP TABLE #TMP2
  END

