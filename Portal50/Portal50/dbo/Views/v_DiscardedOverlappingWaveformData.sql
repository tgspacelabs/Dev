
CREATE VIEW [dbo].[v_DiscardedOverlappingWaveformData]
AS
	SELECT [WF1].[Id], [WF1].[TopicSessionId], [WF1].[FileTimeStampBeginUTC], [WF1].[FileTimeStampEndUTC]
		FROM [dbo].[v_LegacyWaveform] AS [WF1]
		INNER JOIN [dbo].[v_LegacyWaveform] AS [WF2]
			ON [WF1].[PatientId] = [WF2].[PatientId]
			AND [WF1].[TypeId] = [WF2].[TypeId]
			AND [WF1].[TopicSessionId] <> [WF2].[TopicSessionId]
			AND [WF1].[SessionBeginUTC] <= [WF2].[SessionBeginUTC]
			AND [WF2].[TimeStampBeginUTC] < [WF1].[TimeStampEndUTC]
			AND [WF1].[TimeStampBeginUTC] < [WF2].[TimeStampEndUTC]
