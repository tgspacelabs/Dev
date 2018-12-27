CREATE PROCEDURE [dbo].[usp_PurgeDlEncounterData]
    (
     @FChunkSize INT,
     @EncounterDataPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PurgeDateTimeUTC DATETIME = DATEADD(DAY, -10, GETUTCDATE());
    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) FROM
            [dbo].[DeviceSessions] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [DeviceSessions].[EndTimeUTC] IS NOT NULL
            AND [DeviceSessions].[EndTimeUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [did]
        FROM
            [dbo].[DeviceInfoData] AS [did] WITH (ROWLOCK) -- Do not allow lock escalations.
            LEFT OUTER JOIN [dbo].[DeviceSessions] AS [ds]
                ON [did].[DeviceSessionId] = [ds].[Id]
        WHERE
            [ds].[Id] IS NULL;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) FROM
            [dbo].[TopicSessions] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [TopicSessions].[EndTimeUTC] IS NOT NULL
            AND [TopicSessions].[EndTimeUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) FROM
            [dbo].[PatientData] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [PatientSessionId] IN (SELECT
                                    [ps].[Id]
                                   FROM
                                    [dbo].[PatientSessions] AS [ps]
                                   WHERE
                                    [ps].[EndTimeUTC] IS NOT NULL
                                    AND [ps].[EndTimeUTC] <= @PurgeDateTimeUTC)
            AND [TimestampUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) FROM
            [dbo].[PatientSessions] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [EndTimeUTC] IS NOT NULL
            AND [EndTimeUTC] <= @PurgeDateTimeUTC
            AND NOT EXISTS ( SELECT
                                1
                             FROM
                                [dbo].[PatientData] AS [pd]
                             WHERE
                                [pd].[PatientSessionId] = [PatientSessions].[Id] );


        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [psm]
        FROM
            [dbo].[PatientSessionsMap] AS [psm] WITH (ROWLOCK) -- Do not allow lock escalations.
            LEFT OUTER JOIN [dbo].[PatientSessions] AS [ps]
                ON [psm].[PatientSessionId] = [ps].[Id]
        WHERE
            [ps].[Id] IS NULL;


        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @EncounterDataPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge the data loader encounter data if the data is older than the specified purge date.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlEncounterData';

