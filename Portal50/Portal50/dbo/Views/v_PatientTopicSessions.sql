
CREATE VIEW [dbo].[v_PatientTopicSessions]
AS
SELECT [TopicSessions].[Id]	AS	[TopicSessionId],
       [PatientMap].[PatientId]
	 FROM 
		[dbo].[PatientSessionsMap] PatientMap 
		INNER JOIN
		   (
			SELECT [PatientSessionId],
				MAX([Sequence]) AS MaxSequence
			FROM 
				[dbo].[PatientSessionsMap] 
			GROUP BY [PatientSessionId]
			) PatientMax 
			ON PatientMax.[PatientSessionId] = PatientMap.[PatientSessionId] AND
			PatientMax.MaxSequence = PatientMap.[Sequence]
		INNER JOIN 
			[dbo].[TopicSessions] 
				ON [TopicSessions].[PatientSessionId]=[PatientMap].[PatientSessionId]
