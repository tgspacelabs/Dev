
CREATE PROCEDURE [dbo].[p_Ins_Plcys]
  (
  @patient_id UNIQUEIDENTIFIER,
  @acct_id    UNIQUEIDENTIFIER
  )
AS
  /* select ins info */
  SELECT DISTINCT
         cob_priority PRIORITY,
         P.plan_xid PLANNO,
         ins_policy_xid POLICYNO,
         I.group_xid GROUPNO,
         I.seq_no,
         Space( 50 ) LASTNAME,
         Space( 50 ) FIRSTNAME,
         Space( 50 ) MIDDLENAME,
         I.holder_rel_cid RELATIONSHIPID,
         holder_id HOLDERID,
         Space( 50 ) CARRIER,
         P.ins_company_id EXT_ORGANIZATION_ID
  INTO   #TMP_INS1
  FROM   int_insurance_policy I,
         int_insurance_plan P
  WHERE  I.patient_id = @patient_id AND I.account_id = @acct_id AND I.plan_id = P.plan_id
  ORDER  BY priority

  /* update external_org */
  UPDATE #TMP_INS1
  SET    carrier = E.organization_nm
  FROM   #TMP_INS1 A,
         int_external_organization E
  WHERE  A.ext_organization_id = E.ext_organization_id

  /* update from person_name */
  UPDATE #TMP_INS1
  SET    lastname = IsNull( last_nm,
                            '' ),
         middlename = IsNull( middle_nm,
                              '' ),
         firstname = IsNull( first_nm,
                             '' )
  FROM   #TMP_INS1,
         int_person_name PN
  WHERE  holderid = PN.person_nm_id AND PN.recognize_nm_cd = 'P' AND active_sw = 1

  /* contact person address */
  SELECT I.*,
         A.line1_dsc ADDR1,
         A.line2_dsc ADDR2,
         A.line3_dsc ADDR3,
         A.city_nm CITY,
         A.state_code STATE,
         A.zip_code ZIP,
         A.country_cid,
         Space( 14 ) TEL_NO,
         Cast( NULL AS UNIQUEIDENTIFIER ) CONTACT_ID
  INTO   #TMP_INS2
  FROM   #TMP_INS1 I
         RIGHT OUTER JOIN int_address A
           ON ( I.ext_organization_id = A.address_id )

  /* phone */
  UPDATE #TMP_INS2
  SET    #tmp_ins2.tel_no = T.tel_no
  FROM   #TMP_INS2 I,
         int_telephone T
  WHERE  I.ext_organization_id = T.phone_id AND T.phone_loc_cd = 'B' AND T.phone_type_cd = 'V' AND T.seq_no =
             ( SELECT mIn( seq_no )
               FROM   int_telephone
               WHERE  T.phone_id = phone_id AND phone_loc_cd = 'B' AND phone_type_cd = 'V' )

  /* contact person  */
  UPDATE #TMP_INS2
  SET    #tmp_ins2.contact_id = IP.ins_contact_id
  FROM   #TMP_INS2 I,
         int_insurance_policy IP
  WHERE  IP.patient_id = @patient_id AND IP.seq_no = I.seq_no AND IP.active_sw = 1

  SELECT I.*,
         PN.last_nm CO_LNAME,
         PN.first_nm CO_FNAME,
         PN.middle_nm CO_MNAME
  FROM   int_person_name PN
         RIGHT OUTER JOIN #TMP_INS2 I
           ON ( I.contact_id = PN.person_nm_id )
  WHERE  PN.recognize_nm_cd = 'P' AND PN.active_sw = 1
  ORDER  BY priority


