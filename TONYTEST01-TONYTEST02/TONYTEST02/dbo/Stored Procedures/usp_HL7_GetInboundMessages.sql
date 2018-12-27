
/* To get the patient details inserted from ADTA01*/
CREATE PROCEDURE [dbo].[usp_HL7_GetInboundMessages]
AS
BEGIN
Select 
Hl7Msg.MessageNo,
Hl7Msg.MessageType,
Hl7Msg.MessageTypeEventCode,
Hl7Msg.MessageControlId,
Hl7Msg.MessageHeaderDate,
Hl7Msg.MessageVersion,
Map.mrn_xid as PatientMrn,
Map.mrn_xid2 as AccountNumber,
PAT.patient_id as PatientId,
Visit.account_id as AccountId,
PAT.dob as DateOfBirth,
PAT.gender_cid as GenderId,
MSCODEGender.code as PatientGender,
PER.first_nm as FirstName,
PER.last_nm as LastName,
PER.middle_nm as MiddleName,
Visit.admit_dt as PatientAdmitedDate,
ORG.organization_cd as Unit,
Visit.vip_sw as Vip,
Visit.rm as Room,
Visit.Bed as Bed,
Visit.patient_class_cid as PatientClassId,
MSCodePatClass.code as PatientClass,
VisitMap.encounter_xid,
Visit.discharge_dt as DischargeDateTime
From 
Hl7InboundMessage AS Hl7Msg
INNER JOIN Hl7PatientLink AS Hl7Link
	ON Hl7Link.MessageNo=Hl7Msg.MessageNo
INNER JOIN int_mrn_map AS Map
	ON Map.mrn_xid=Hl7Link.PatientMrn 
INNER JOIN int_patient as Pat
	ON Pat.patient_id=Map.patient_id
INNER JOIN int_person as PER
	On PER.person_id=Pat.patient_id
INNER JOIN int_encounter as Visit
	ON Visit.patient_id=Map.patient_id
Inner join int_encounter_map as VisitMap
	ON VisitMap.encounter_id= Visit.encounter_id
INNER JOIN int_organization as ORG
	ON org.organization_id=Visit.unit_org_id
LEFT OUTER JOIN int_misc_code as MSCodeGender
	ON MSCodeGender.code_id=PAT.gender_cid AND MSCodeGender.category_cd='SEX' and MSCodeGender.method_cd='Hl7'
LEFT OUTER JOIN int_misc_code as MSCodePatClass
	On MSCodePatClass.code_id=Visit.patient_class_cid and MSCodePatClass.category_cd='PCLS' and MSCodePatClass.method_cd='Hl7'
END

