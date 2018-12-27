

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
        DELETE TOP (@FChunkSize)
            [dbo].[DeviceSessions]
        WHERE
            [EndTimeUTC] IS NOT NULL
            AND [EndTimeUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[TopicSessions]
        WHERE
            [EndTimeUTC] IS NOT NULL
            AND [EndTimeUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[PatientSessions]
        WHERE
            [EndTimeUTC] IS NOT NULL
            AND [EndTimeUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [dbo].[PatientData]
        WHERE
            [PatientSessionId] IN (SELECT
                                                [Id]
                                             FROM
                                                [dbo].[PatientSessions]
                                             WHERE
                                                [EndTimeUTC] IS NOT NULL)
            AND [TimestampUTC] <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @EncounterDataPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlEncounterData';

