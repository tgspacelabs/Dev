
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
        DELETE TOP (@FChunkSize) [dbo].[DeviceSessions]
        WHERE DeviceSessions.EndTimeUTC IS NOT NULL AND DeviceSessions.EndTimeUTC <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[TopicSessions]
        WHERE TopicSessions.EndTimeUTC IS NOT NULL AND TopicSessions.EndTimeUTC <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[PatientSessions]
        WHERE PatientSessions.EndTimeUTC IS NOT NULL AND PatientSessions.EndTimeUTC <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[PatientData]
        WHERE PatientData.PatientSessionId IN (SELECT PatientSessions.[Id] FROM PatientSessions WHERE EndTimeUTC IS NOT NULL)
            AND PatientData.TimestampUTC <= @PurgeDateTimeUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @EncounterDataPurged = @RC;
END
