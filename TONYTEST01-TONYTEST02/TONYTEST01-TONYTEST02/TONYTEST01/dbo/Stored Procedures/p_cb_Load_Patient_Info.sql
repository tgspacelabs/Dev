
CREATE PROCEDURE [dbo].[p_cb_Load_Patient_Info]
  (
  @patientID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT PT.living_will_sw WILL,
           PT.organ_donor_sw DONOR,
           PT.ethnic_group_cid RACE,
           PT.marital_status_cid MARRIED,
           PT.religion_cid RELIGON,
           PT.birth_place,
           PT.ssn,
           PN.last_nm ALIAS_LAST_NM,
           PN.first_nm ALIAS_FIRST_NM,
           PN.middle_nm ALIAS_MIDDLE_NM,
           A.line1_dsc ADDR1,
           A.line2_dsc ADDR2,
           A.line3_dsc ADDR3,
           A.city_nm,
           A.state_code,
           A.zip_code,
           A.country_cid
    FROM   dbo.int_patient PT
           LEFT OUTER JOIN dbo.int_person_name PN
             ON ( PT.patient_id = PN.person_nm_id ) AND ( PN.recognize_nm_cd = 'A' ) AND PN.seq_no =
                    ( SELECT mIn( seq_no )
                      FROM   int_person_name
                      WHERE  person_nm_id = PT.patient_id AND int_person_name.active_sw = 1 AND int_person_name.recognize_nm_cd = 'A' )
           LEFT OUTER JOIN dbo.int_address A
             ON ( PT.patient_id = A.address_id ) AND A.addr_type_cd = 'M'
    WHERE  ( PT.patient_id = @patientID )
  END

