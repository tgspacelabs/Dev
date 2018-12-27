
/*[usp_HL7_GetPersonAndPatientDataByPatientID] get the  patient details by patient id*/
CREATE PROCEDURE [dbo].[usp_HL7_GetPersonAndPatientDataByPatientID](@PatientId UNIQUEIDENTIFIER)
AS
BEGIN
	SET NOCOUNT ON;
		SELECT 
		Pat.dob AS DateOfBirth, 
		Pat.gender_cid AS GenderCd, 
		Pat.race_cid AS RaceCd, 
		Pat.primary_language_cid AS PrimLangCode, 
		Pat.marital_status_cid AS MaritalStatusCd,
		Pat.religion_cid AS ReligionCd, 
		Pat.ssn AS SSN,
		Pat.driv_lic_no AS DLNo, 
		Pat.driv_lic_state_code AS DLStateCd, 
		Pat.ethnic_group_cid AS EthnicGrpCd,
		Pat.birth_place AS BirthPlace, 
		Pat.birth_order AS BirthOrder, 
		Pat.nationality_cid AS NationalityCode, 
		Pat.citizenship_cid AS CitizenshipCode, 
		Pat.veteran_status_cid AS VeteranStatusCode, 
		Pat.death_dt AS DeathDate, 
		Pat.organ_donor_sw AS OrganDonor, 
		Pat.living_will_sw AS LivingWill, 
		person.first_nm AS FirstName, 
		person.middle_nm AS MiddleName, 
		person.last_nm AS LastName, 
		person.suffix AS Suffix, 
		person.tel_no AS Telephone, 
		person.line1_dsc AS Address1,
		person.line2_dsc AS Address2,
		person.line3_dsc AS Address3, 
		person.city_nm AS City, 
		person.state_code AS StateCode, 
		person.zip_code AS Zip, 
		person.country_cid AS CountryCode, 
		int_mrn_map.mrn_xid2 as AccountNumber,
		int_mrn_map.mrn_xid as MRN
		FROM  int_patient AS Pat 
		INNER JOIN int_person AS person 
			ON Pat.patient_id = person.person_id AND Pat.patient_id = @PatientId  
		INNER JOIN int_mrn_map 
			ON Pat.patient_id = int_mrn_map.patient_id
		WHERE (int_mrn_map.merge_cd = 'C')
		UNION
		SELECT
		NULL AS DateOfBirth, 
		NULL AS GenderCd, 
		NULL AS RaceCd, 
		NULL AS PrimLangCode, 
		NULL AS MaritalStatusCd,
		NULL AS ReligionCd, 
		NULL AS SSN,
		NULL AS DLNo, 
		NULL AS DLStateCd, 
		NULL AS EthnicGrpCd,
		NULL AS BirthPlace, 
		NULL AS BirthOrder, 
		NULL AS NationalityCode, 
		NULL AS CitizenshipCode, 
		NULL AS VeteranStatusCode, 
		NULL AS DeathDate, 
		NULL AS OrganDonor, 
		NULL AS LivingWill, 
		FIRST_NAME AS FirstName, 
		MIDDLE_NAME AS MiddleName, 
		LAST_NAME AS LastName, 
		NULL AS Suffix, 
		NULL AS Telephone, 
		NULL AS Address1,
		NULL AS Address2,
		NULL AS Address3, 
		NULL AS City, 
		NULL AS StateCode, 
		NULL AS Zip, 
		NULL AS CountryCode,
		ACCOUNT_ID as AccountNumber,
		MRN_ID as MRN
		FROM [dbo].[v_PatientSessions]
		WHERE PATIENT_ID = @PatientId
	SET NOCOUNT OFF;
END
