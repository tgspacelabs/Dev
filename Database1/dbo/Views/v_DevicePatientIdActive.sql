

CREATE VIEW [dbo].[v_DevicePatientIdActive]
AS
SELECT DISTINCT [LatestPatientAssignment].[DeviceId],
                [int_mrn_map].[mrn_xid] AS [ID1],
	            [LatestPatientSessionsMap].[PatientId]
FROM [dbo].[PatientSessions]
INNER JOIN
(
	SELECT [PatientSessionId]
	      ,[DeviceId]
		FROM
		(
			SELECT [PatientSessionId]
			      ,[DeviceId]
				  ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
				FROM [dbo].[PatientData]
				INNER JOIN [dbo].[DeviceSessions]
					ON [DeviceSessions].[EndTimeUTC] IS NULL AND [DeviceSessions].[Id]=[PatientData].[DeviceSessionId]
		) AS [PatientAssignmentSequence]
		WHERE [R]=1
) AS [LatestPatientAssignment]
	ON [LatestPatientAssignment].[PatientSessionId]=[PatientSessions].[Id]
INNER JOIN
(
	SELECT [PatientSessionId]
	      ,[PatientId]
		FROM
		(
			SELECT [PatientSessionId]
			      ,[PatientId]
				  ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
				FROM [dbo].[PatientSessionsMap]
		) AS [PatientSessionsMapSequence]
		WHERE [R]=1
) AS [LatestPatientSessionsMap]
	ON [LatestPatientSessionsMap].[PatientSessionId]=[PatientSessions].[Id]
INNER JOIN [dbo].[int_mrn_map]
	ON [int_mrn_map].[patient_id]=[LatestPatientSessionsMap].[PatientId]


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_DevicePatientIdActive';

