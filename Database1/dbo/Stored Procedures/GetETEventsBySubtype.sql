CREATE PROCEDURE [dbo].[GetETEventsBySubtype]
    (
     @patient_id UNIQUEIDENTIFIER,
     @Subtype INT,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @l_StartTime_dt DATETIME = [dbo].[fnFileTimeToDateTime](@StartTime),
        @l_EndTime_dt DATETIME = [dbo].[fnFileTimeToDateTime](@EndTime);

    SELECT
        ISNULL([EndOrUpdateEventsData].[Value1], [AllRhythmEvents].[StartValue1]) AS [VALUE1], -- return the most recent available value  
        ISNULL([EndOrUpdateEventsData].[Value2], [AllRhythmEvents].[StartValue2]) AS [VALUE2], -- return the most recent available value  
        ISNULL([EndOrUpdateEventsData].[status], [AllRhythmEvents].[StartStatus]) AS [STATUS_VALUE], -- return the most recent available value  
        ISNULL([EndOrUpdateEventsData].[valid_leads], [AllRhythmEvents].[StartValidLeads]) AS [LEADS], -- return the most recent available value  
        [dbo].[fnDateTimeToFileTime]([AllRhythmEvents].[StartTime]) AS [FT_TIME_START], -- ALWAYS RETURN THE START TIME OF THE EVENT EVEN IF IT'S OUT OF THE REQUESTED RANGE
        [dbo].[fnDateTimeToFileTime]([AllRhythmEvents].[EndOrUpdateTime]) AS [FT_TIME_END],
        [AllRhythmEvents].[StartTime],
        [AllRhythmEvents].[EndOrUpdateTime]
    FROM
        (SELECT
            [EventsDataStart].[Value1] AS [StartValue1],
            [EventsDataStart].[Value2] AS [StartValue2],
            [EventsDataStart].[status] AS [StartStatus],
            [EventsDataStart].[valid_leads] AS [StartValidLeads],
            [EventsDataStart].[TopicSessionId],
            [EventsDataStart].[CategoryValue],
            [EventsDataStart].[Subtype],
            [EventsDataStart].[TimeStampUTC] AS [StartTime],
            (SELECT
                COALESCE((SELECT TOP (1)
                            [EventsDataEnd].[TimeStampUTC]
                          FROM
                            [dbo].[EventsData] AS [EventsDataEnd]
                          WHERE
                            [EventsDataEnd].[Type] = 4
                            AND [EventsDataEnd].[CategoryValue] = 2
                            AND [EventsDataEnd].[Subtype] = @Subtype
                            AND [EventsDataEnd].[TopicSessionId] = [EventsDataStart].[TopicSessionId]
                            AND [EventsDataEnd].[TimeStampUTC] > [EventsDataStart].[TimeStampUTC]
                          ORDER BY
                            [EventsDataEnd].[TimeStampUTC] ASC
                         ), (SELECT TOP (1)
                                [EventsDataUpdate].[TimeStampUTC]
                             FROM
                                [dbo].[EventsData] AS [EventsDataUpdate]
                             WHERE
                                [EventsDataUpdate].[Type] = 12
                                AND [EventsDataUpdate].[CategoryValue] = 2
                                AND [EventsDataUpdate].[Subtype] = @Subtype
                                AND [EventsDataUpdate].[TopicSessionId] = [EventsDataStart].[TopicSessionId]
                                AND [EventsDataUpdate].[TimeStampUTC] > [EventsDataStart].[TimeStampUTC]
                             ORDER BY
                                [EventsDataUpdate].[TimeStampUTC] DESC
                            ), (SELECT
                                    [ts].[EndTimeUTC]
                                FROM
                                    [dbo].[TopicSessions] AS [ts]
                                WHERE
                                    [ts].[Id] = [EventsDataStart].[TopicSessionId]
                               ))
            ) AS [EndOrUpdateTime]
         FROM
            [dbo].[EventsData] AS [EventsDataStart]
            INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [EventsDataStart].[TopicSessionId]
         WHERE
            [vpts].[PatientId] = @patient_id
            AND [EventsDataStart].[Type] = 3
            AND [EventsDataStart].[CategoryValue] = 2
            AND [EventsDataStart].[Subtype] = @Subtype
        ) AS [AllRhythmEvents]
        LEFT OUTER JOIN [dbo].[EventsData] AS [EndOrUpdateEventsData] ON [EndOrUpdateEventsData].[CategoryValue] = [AllRhythmEvents].[CategoryValue]
                                                                         AND [EndOrUpdateEventsData].[Subtype] = [AllRhythmEvents].[Subtype]
                                                                         AND [EndOrUpdateEventsData].[TopicSessionId] = [AllRhythmEvents].[TopicSessionId]
                                                                         AND [EndOrUpdateEventsData].[TimeStampUTC] = [AllRhythmEvents].[EndOrUpdateTime]
    WHERE
        [AllRhythmEvents].[EndOrUpdateTime] IS NULL
        OR [AllRhythmEvents].[EndOrUpdateTime] > @l_StartTime_dt; 
        -- Do not filter out the start time of the event as we need to collect something when the request time 
        -- range is between an event start and end times, and we still need that active event to be returned
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETEventsBySubtype';

