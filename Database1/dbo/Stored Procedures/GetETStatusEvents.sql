

CREATE PROCEDURE [dbo].[GetETStatusEvents]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @l_patientId UNIQUEIDENTIFIER= @patient_id;

    SELECT
        [ev].[Subtype] AS [SUBTYPE],
        [ev].[Value1] AS [VALUE1],
        [ev].[status] AS [STATUS_VALUE],
        [ev].[valid_leads] AS [LEADS],
        [dbo].[fnDateTimeToFileTime]([ev].[TimeStampUTC]) AS [FT_TIME],
        @patient_id AS [PATIENT_ID],
        ISNULL([dbo].[fnDateTimeToFileTime]([EndTimeUTC]), -1) AS [MAX_FT_TIME]
    FROM
        [dbo].[EventsData] [ev]
        INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [ev].[TopicSessionId]
        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [ev].[TopicSessionId]
    WHERE
        [PatientId] = @l_patientId
        AND [ev].[CategoryValue] = 2
        AND [ev].[Type] = 1
    ORDER BY
        [FT_TIME];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETStatusEvents';

