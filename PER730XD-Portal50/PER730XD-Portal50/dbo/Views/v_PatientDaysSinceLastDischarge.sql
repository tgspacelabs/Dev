

CREATE VIEW [dbo].[v_PatientDaysSinceLastDischarge]
AS
    SELECT [PatientId] = [patient_id],
           [DaysSinceLastDischarge] = MIN(DATEDIFF(day, ISNULL([discharge_dt], GETDATE()), GETDATE()))
        FROM [dbo].[int_encounter]
        GROUP BY [patient_id]

UNION ALL

    SELECT [PatientId]
          ,[DaysSinceLastDischarge] = MIN(DATEDIFF(day, ISNULL([EndTimeUTC], GETUTCDATE()), GETUTCDATE()))
        FROM [dbo].[PatientSessions]
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
                ) AS [PatientSessionAssignmentSequence]
                WHERE [R]=1
        ) AS [LatestPatientSessionAssignment]
            ON [LatestPatientSessionAssignment].[PatientSessionId]=[PatientSessions].[Id]
        GROUP BY [PatientId]

