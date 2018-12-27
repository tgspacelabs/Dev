﻿
CREATE PROCEDURE [dbo].[usp_GetPatientInformation]
	(@deviceIds [dbo].[GetPatientUpdateInformationType] READONLY)
AS
BEGIN

	SET NOCOUNT ON

	SELECT DISTINCT
	       [Ids].[DeviceId]
	      ,[ID1] =
			CASE
				WHEN [v_DevicePatientIdActive].[DeviceId] IS NULL
				AND [int_patient_monitor].[monitor_id] IS NULL
					THEN [mrn_xid]
				ELSE [dbo].[fnMarkIdAsDuplicate]([mrn_xid])
			END
		  ,[ID2] = [mrn_xid2]
		  ,[FirstName] = [first_nm]
		  ,[MiddleName] = [middle_nm]
		  ,[LastName] = [last_nm]
		  ,[Gender] =
			CASE [gender_code].[code]
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
				ELSE NULL
			END
		  ,[DOB] = CONVERT(VARCHAR, [dob], 126)
		  ,[BSA] = CAST([bsa] AS VARCHAR)

		FROM @deviceIds AS [Ids]
		INNER JOIN [dbo].[int_mrn_map] ON [int_mrn_map].[mrn_xid]=[Ids].[ID1] AND [int_mrn_map].[merge_cd]='C'
		LEFT OUTER JOIN [dbo].[int_patient] ON [int_patient].[patient_id]=[int_mrn_map].[patient_id]
		LEFT OUTER JOIN [dbo].[int_person] ON [int_person].[person_id]=[int_mrn_map].[patient_id]
		LEFT OUTER JOIN [dbo].[int_misc_code] AS [gender_code] ON [gender_code].[code_id]=[int_patient].[gender_cid]
		LEFT OUTER JOIN [dbo].[v_DevicePatientIdActive]
			ON [v_DevicePatientIdActive].[DeviceId] <> [Ids].[DeviceId]
			AND [v_DevicePatientIdActive].[ID1] = [Ids].[ID1]
		LEFT OUTER JOIN [dbo].[int_patient_monitor]
			ON [int_patient_monitor].[patient_id] = [int_mrn_map].[patient_id]
			AND [int_patient_monitor].[active_sw]='1'
END 
