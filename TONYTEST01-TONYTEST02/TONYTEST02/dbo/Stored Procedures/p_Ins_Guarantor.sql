
CREATE PROCEDURE [dbo].[p_Ins_Guarantor]
  (
  @patient_id UNIQUEIDENTIFIER,
  @enc_id     UNIQUEIDENTIFIER
  )
AS
  DECLARE
    @acct_id                UNIQUEIDENTIFIER,
    @gu_id                  UNIQUEIDENTIFIER,
    @gu_lname               VARCHAR(50),
    @gu_fname               VARCHAR(50),
    @gu_mname               VARCHAR(50),
    @pat_rel                VARCHAR(30),
    @pat_rel_id             INT,
    @gu_addr1               VARCHAR(50),
    @gu_addr2               VARCHAR(50),
    @gu_addr3               VARCHAR(50),
    @gu_city                VARCHAR(25),
    @gu_state               CHAR(3),
    @gu_zip                 CHAR(10),
    @gu_country_code_id     INT,
    @gu_home_ph             CHAR(40),
    @gu_home_ext            CHAR(12),
    @gu_work_ph             CHAR(40),
    @gu_work_ext            CHAR(12),
    @gu_emer_ph             CHAR(40),
    @gu_emer_ext            CHAR(5),
    @emplyr_id              UNIQUEIDENTIFIER,
    @emplyr_nm              VARCHAR(50),
    @emplyr_addr1           VARCHAR(50),
    @emplyr_addr2           VARCHAR(50),
    @emplyr_addr3           VARCHAR(50),
    @emplyr_city            VARCHAR(25),
    @emplyr_state           CHAR(3),
    @emplyr_zip             CHAR(10),
    @emplyr_country_code_id INT,
    @emplyr_work_ph         CHAR(40),
    @emplyr_work_ext        CHAR(5),
    @emplyr_emer_ph         CHAR(40),
    @emplyr_emer_ext        CHAR(5),
    @seq_no                 INT

  /* Look up the acct_id in the encounter    */
  SELECT @acct_id = account_id
  FROM   int_encounter
  WHERE  patient_id = @patient_id AND encounter_id = @enc_id

  /* Look up the latest desc_key for this account  */
  SELECT @seq_no = Max( seq_no )
  FROM   int_guarantor
  WHERE  patient_id = @patient_id AND encounter_id = @enc_id AND active_sw = 1

  SELECT @gu_id = guarantor_person_id,
         @emplyr_id = employer_id
  FROM   int_guarantor
  WHERE  patient_id = @patient_id AND encounter_id = @enc_id AND seq_no = @seq_no

  SELECT @pat_rel = short_dsc,
         @pat_rel_id = relationship_cid
  FROM   int_guarantor,
         int_misc_code
  WHERE  patient_id = @patient_id AND ( encounter_id = @enc_id  OR encounter_id IS NULL ) AND guarantor_person_id = @gu_id AND relationship_cid = code_id

  IF ( @pat_rel_id = NULL )
    BEGIN
      SELECT @pat_rel = short_dsc,
             @pat_rel_id = relationship_cid
      FROM   guarantor,
             misc_code
      WHERE  patient_id = @patient_id AND ( encounter_id = @enc_id  OR encounter_id IS NULL ) AND company_id = @gu_id AND relationship_cid = code_id
    END

  SELECT @gu_lname = last_nm,
         @gu_fname = first_nm,
         @gu_mname = middle_nm
  FROM   int_person_name
  WHERE  person_nm_id = @gu_id AND recognize_nm_cd = 'P' AND active_sw = 1

/* Use the ent_id of the guarantor as the key to get the */
  /* address from the address table   */
  SELECT @gu_addr1 = line1_dsc,
         @gu_addr2 = line2_dsc,
         @gu_addr3 = line3_dsc,
         @gu_city = city_nm,
         @gu_state = state_code,
         @gu_zip = zip_code,
         @gu_country_code_id = country_cid
  FROM   int_address
  WHERE  address_id = @gu_id

  SELECT @emplyr_addr1 = A.line1_dsc,
         @emplyr_addr2 = A.line2_dsc,
         @emplyr_addr3 = A.line3_dsc,
         @emplyr_city = A.city_nm,
         @emplyr_state = A.state_code,
         @emplyr_zip = A.zip_code,
         @emplyr_country_code_id = A.country_cid
  FROM   int_address A
  WHERE  A.address_id = @emplyr_id AND A.addr_type_cd = 'M'

  SELECT @emplyr_nm = organization_nm
  FROM   int_external_organization
  WHERE  ext_organization_id = @emplyr_id

  /* Look up the guarantor's home phone number  */
  SELECT @gu_home_ph = tel_no,
         @gu_home_ext = ext_no
  FROM   int_telephone
  WHERE  @gu_id = phone_id AND phone_loc_cd = 'R' AND phone_type_cd = 'V'
  ORDER  BY seq_no DESC /* the one with min seq_no */

  /* Look up the guarantor's work phone number  */
  SELECT @gu_work_ph = tel_no,
         @gu_work_ext = ext_no
  FROM   int_telephone
  WHERE  @gu_id = phone_id AND phone_loc_cd = 'B' AND phone_type_cd = 'V'
  ORDER  BY seq_no DESC /* the one with min seq_no*/

  /* Look up the guarantor's emergency home phone number  */
  SELECT @gu_emer_ph = tel_no,
         @gu_emer_ext = ext_no
  FROM   int_telephone
  WHERE  @gu_id = phone_id AND phone_loc_cd = 'E' AND phone_type_cd = 'V'
  ORDER  BY seq_no DESC /* the one with min seq_no */

  /* Look up the employer's work phone number */
  SELECT @emplyr_work_ph = tel_no,
         @emplyr_work_ext = ext_no
  FROM   int_telephone
  WHERE  @emplyr_id = phone_id AND phone_loc_cd = 'B' AND phone_type_cd = 'V'
  ORDER  BY seq_no DESC /* the one with min seq_no */

  /* Look up the employer's emergency work phone number  */
  SELECT @emplyr_emer_ph = tel_no,
         @emplyr_emer_ext = ext_no
  FROM   int_telephone
  WHERE  @emplyr_id = phone_id AND phone_loc_cd = 'M' AND phone_type_cd = 'V'
  ORDER  BY seq_no DESC /* the one with min seq_no */

  SELECT ID = @gu_id,
         LAST = @gu_lname,
         FIRST = @gu_fname,
         MIDDLE = @gu_mname,
         RELATION = @pat_rel,
         RELATION_CODE_ID = @pat_rel_id,
         ADDR1 = @gu_addr1,
         ADDR2 = @gu_addr2,
         ADDR3 = @gu_addr3,
         CITY = @gu_city,
         STATE = @gu_state,
         ZIP = @gu_zip,
         COUNTRY_CODE_ID = @gu_country_code_id,
         H_PHONE = @gu_home_ph,
         HOME_EXT = @gu_home_ext,
         W_PHONE = @gu_work_ph,
         WORK_EXT = @gu_work_ext,
         EMR_PHONE = @gu_emer_ph,
         EMR_EXT = @gu_emer_ext,
         EMPL_ID = @emplyr_id,
         EMPL_NAME = @emplyr_nm,
         EMPL_ADDR1 = @emplyr_addr1,
         EMPL_ADDR2 = @emplyr_addr2,
         EMPL_ADDR3 = @emplyr_addr3,
         EMP_CITY = @emplyr_city,
         EMP_ST = @emplyr_state,
         EMP_ZIP = @emplyr_zip,
         EMP_COUNTRY_CODE_ID = @emplyr_country_code_id,
         EMP_PHONE = @emplyr_work_ph,
         EMP_EXT = @emplyr_work_ext,
         EMP_EMR_PHONE = @emplyr_emer_ph,
         EMP_RMR_EXT = @emplyr_emer_ext


