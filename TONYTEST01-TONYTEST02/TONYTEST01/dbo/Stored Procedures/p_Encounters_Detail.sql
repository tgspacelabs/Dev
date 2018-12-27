
/****** Object:  StoredProcedure [dbo].[p_encounters_detail]    Script Date: 08/11/2006 11:47:40 ******/
/****** For Localizing the Not Available string  ******/
CREATE PROCEDURE [dbo].[p_Encounters_Detail]
  (
  @patient_id  UNIQUEIDENTIFIER,
  @strNotAvail VARCHAR(100)
  )
AS
  DECLARE
    @acct_no   CHAR(40),
    @short_dsc VARCHAR(50),
    @diagnosis VARCHAR(255),
    @pat_type  VARCHAR(30),
    @pat_class VARCHAR(30)

  SET @acct_no = 'SEE DETAIL'

  SET @short_dsc = ''

  SET @diagnosis = ' '

  SET @pat_type = ''

  SET @pat_class = ''

  SELECT DISTINCT
         TMP_ACCT_XID = @acct_no,
         TMP_ACCT_ID = A.account_id,
         TMP_ENC_ID = A.encounter_id,
         TMP_ENC_XID = C.encounter_xid,
         TMP_PAT_TYPE_ID = A.patient_type_cid,
         TMP_PAT_TYPE = @pat_type,
         TMP_PAT_CLASS_ID = A.patient_class_cid,
         TMP_PAT_CLASS = @pat_class,
         TMP_ADMIT_DT = A.admit_dt,
         TMP_DISCH_DT = A.discharge_dt,
         TMP_MED_SRVC_ID = A.med_svc_cid,
         TMP_MED_SRVC = Space ( 20 ),
         TMP_DIAG_ID = 0,
         TMP_DIAGNOSIS = @diagnosis,
         TMP_DR_ID = A.attend_hcp_id,
         TMP_ENC_STATUS_CD = A.status_cd,
         TMP_DR_LAST_NAME = B.last_nm,
         TMP_DR_FIRST_NAME = B.first_nm,
         TMP_DR_MIDDLE_NAME = B.middle_nm,
         TMP_ENC_MAP_STATUS_CD = C.status_cd,
         TMP_STAT_ACT_CODE = C.event_cd,
         TMP_VIP_SW = A.vip_sw,
         TMP_DEPT_CODE = Space ( 20 ),
         TMP_DEPT_ID = A.unit_org_id,
         TMP_ROOM = A.rm,
         TMP_BED = A.bed,
         TMP_DISPO_CID = A.discharge_dispo_cid
  INTO   #ENCOUNTERS
  FROM   int_encounter A
         LEFT OUTER JOIN int_hcp B
           ON ( A.attend_hcp_id = B.hcp_id ),
         int_encounter_map C
  WHERE  @patient_id = C.patient_id AND C.encounter_id = A.encounter_id AND C.status_cd IN ( 'N', 'S', 'C' ) AND ( ( A.status_cd != 'X' )  OR ( A.status_cd IS NULL ) ) /* filter canceled encounters */

  UPDATE #ENCOUNTERS
  SET    tmp_diagnosis = IsNull( dsc,
                                 ' ' ),
         tmp_diag_id = IsNull( diagnosis_cid,
                               0 )
  FROM   #ENCOUNTERS A,
         int_diagnosis B
  WHERE  A.tmp_enc_id = B.encounter_id AND B.inactive_sw IS NULL AND B.seq_no =
             ( SELECT Max( seq_no )
               FROM   #ENCOUNTERS A,
                      int_diagnosis B
               WHERE  A.tmp_enc_id = B.encounter_id AND inactive_sw IS NULL )

  /* update each of the records in the temporary table that have an account number and have not been moved or merged */
  UPDATE #ENCOUNTERS
  SET    tmp_acct_xid = int_account.account_xid
  FROM   #ENCOUNTERS,
         int_encounter,
         int_account
  WHERE  #encounters.tmp_enc_id = int_encounter.encounter_id AND int_encounter.patient_id = @patient_id AND int_encounter.account_id = int_account.account_id AND int_account.account_xid IS NOT NULL AND tmp_enc_map_status_cd != 'N'

  /*update each of the records in the temporary table that do not have an account number and have not been moved or merged */
  UPDATE #ENCOUNTERS
  SET    tmp_acct_xid = @strNotAvail
  FROM   #ENCOUNTERS
  WHERE  #encounters.tmp_acct_xid = @acct_no /* SEE DETAIL */
         AND tmp_enc_map_status_cd != 'N' AND tmp_enc_map_status_cd != 'S'

  UPDATE #ENCOUNTERS
  SET    tmp_diagnosis = short_dsc
  FROM   #ENCOUNTERS,
         int_misc_code
  WHERE  tmp_diag_id = code_id AND tmp_diag_id != 0

  /* Retrieve patient class and type from misc_code; short_dsc is NULL */
  UPDATE #ENCOUNTERS
  SET    tmp_pat_type = IsNull( M.short_dsc,
                                '' ),
         tmp_pat_class = IsNull( M2.short_dsc,
                                 '' )
  FROM   #ENCOUNTERS
         LEFT OUTER JOIN int_misc_code M
           ON ( tmp_pat_type_id = M.code_id ),
         int_misc_code M2
  WHERE  tmp_pat_class_id = M2.code_id

  /* Retrieve medical service from misc_code; ignore if short_dsc is NULL */
  UPDATE #ENCOUNTERS
  SET    tmp_med_srvc = short_dsc
  FROM   #ENCOUNTERS,
         int_misc_code
  WHERE  tmp_med_srvc_id = code_id AND short_dsc IS NOT NULL

  UPDATE #ENCOUNTERS
  SET    tmp_dept_code = organization_cd
  FROM   int_organization
  WHERE  #encounters.tmp_dept_id = int_organization.organization_id

  /*  data has been built now select out all data   */
  SELECT tmp_acct_xid,
         tmp_enc_id,
         tmp_acct_id,
         tmp_pat_type,
         tmp_admit_dt,
         tmp_disch_dt,
         tmp_med_srvc,
         tmp_diagnosis,
         tmp_enc_status_cd,
         tmp_dr_id,
         tmp_dr_last_name,
         tmp_dr_first_name,
         tmp_dr_middle_name,
         tmp_enc_map_status_cd,
         tmp_enc_xid,
         tmp_stat_act_code,
         tmp_pat_class,
         tmp_vip_sw,
         tmp_dept_code,
         tmp_dept_id,
         tmp_room,
         tmp_bed,
         tmp_dispo_cid
  FROM   #ENCOUNTERS
  ORDER  BY tmp_admit_dt DESC

  DROP TABLE #ENCOUNTERS

