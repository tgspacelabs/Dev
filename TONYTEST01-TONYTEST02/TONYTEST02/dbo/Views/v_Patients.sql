
CREATE VIEW [dbo].[v_Patients]
AS 
    SELECT DISTINCT
       [PATIENT_ID],
       [FIRST_NAME],
       [MIDDLE_NAME],
       [LAST_NAME],
       [PATIENT_NAME],
       [MRN_ID] AS [ID1],
       [ACCOUNT_ID] AS [ID2],
       [DOB], 
       [FACILITY_NAME]
FROM [dbo].[v_PatientSessions]
