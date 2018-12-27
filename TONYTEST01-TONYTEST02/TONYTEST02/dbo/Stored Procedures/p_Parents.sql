
CREATE PROCEDURE [dbo].[p_Parents]
  (
  @person_id UNIQUEIDENTIFIER
  )
AS
  /*------------------------------------------------------------
   * $Id: p_parents.sql,v 1.4 1997/09/10 16:19:14 dipti Exp $
   *
   * select the record with relationship code of MOTHER and
   * role code of a NOK if one exists otherwise (b Guardian 
   * Since there could be multiple records with same role code and
   * relationship code id, select the one with min desc key.
   * The use the ent id to get the mother's name 
   *------------------------------------------------------------*/
  DECLARE
    @mom_ent_id UNIQUEIDENTIFIER,
    @dad_ent_id UNIQUEIDENTIFIER

  SELECT code_id,
         int_keystone_cd
  INTO   #TMP_MISC_CODE
  FROM   int_misc_code
  WHERE  int_keystone_cd IN ( 'MOTHER', 'FATHER' ) AND category_cd = 'RELA'

  SELECT @mom_ent_id = nok_person_id
  FROM   int_nok N,
         #TMP_MISC_CODE T
  WHERE  N.patient_id = @person_id AND N.relationship_cid = T.code_id AND T.int_keystone_cd = 'MOTHER'
  ORDER  BY seq_no DESC

  IF ( @mom_ent_id = NULL )
    BEGIN
      SELECT @mom_ent_id = guarantor_person_id
      FROM   guarantor G,
             #TMP_MISC_CODE T
      WHERE  G.patient_id = @person_id AND G.relationship_cid = T.code_id AND T.int_keystone_code = 'MOTHER'
      ORDER  BY seq_no DESC
    END

  /* select the one with max role_code and msx seq_no*/
  SELECT @dad_ent_id = nok_person_id
  FROM   int_nok N,
         #TMP_MISC_CODE T
  WHERE  N.patient_id = @person_id AND N.relationship_cid = T.code_id AND T.int_keystone_cd = 'FATHER'
  ORDER  BY seq_no DESC

  IF ( @dad_ent_id = NULL )
    BEGIN
      SELECT @dad_ent_id = guarantor_person_id
      FROM   guarantor G,
             #TMP_MISC_CODE T
      WHERE  G.patient_id = @person_id AND G.relationship_cid = T.code_id AND T.int_keystone_code = 'FATHER'
      ORDER  BY seq_no DESC
    END

  /* select the one with max role_code and min desc_key */
  SELECT PN.last_nm,
         PN.first_nm,
         PN.middle_nm,
         PN.suffix,
         'MOM' CODE
  FROM   int_person_name PN
  WHERE  PN.person_nm_id = @mom_ent_id AND PN.recognize_nm_cd = 'P' AND active_sw = 1
  UNION
  SELECT PN.last_nm,
         PN.first_nm,
         PN.middle_nm,
         PN.suffix,
         'DAD' CODE
  FROM   int_person_name PN
  WHERE  PN.person_nm_id = @dad_ent_id AND PN.recognize_nm_cd = 'P' AND active_sw = 1

  DROP TABLE #TMP_MISC_CODE


