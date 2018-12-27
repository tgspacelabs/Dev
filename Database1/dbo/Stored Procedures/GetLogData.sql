

CREATE PROCEDURE [dbo].[GetLogData]
    (
     @StartDate DATETIME,
     @EndDate DATETIME,
     @LogType VARCHAR(64),
     @PatientID DPATIENT_ID,
     @Application VARCHAR(256),
     @DeviceName VARCHAR(256)
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ld].[LogId],
        [ld].[DateTime],
        [ld].[PatientID],
        [ld].[Application],
        [ld].[DeviceName],
        [ld].[Message],
        [ld].[LocalizedMessage],
        [ld].[MessageId],
        [ld].[LogType]
    FROM
        [dbo].[LogData] AS [ld]
    WHERE
        [ld].[DateTime] >= @StartDate
        AND [ld].[DateTime] <= @EndDate
        AND ([ld].[LogType] = @LogType
        OR @LogType IS NULL
        )
        AND ([ld].[PatientID] = @PatientID
        OR @PatientID IS NULL
        )
        AND ([ld].[DeviceName] = @DeviceName
        OR @DeviceName IS NULL
        )
        AND ([ld].[Application] = @Application
        OR @Application IS NULL
        );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetLogData';

