
CREATE PROCEDURE [dbo].[GetLogData]
  (
  @StartDate   DATETIME,
  @EndDate     DATETIME,
  @LogType     VARCHAR(64),
  @PatientID   DPATIENT_ID,
  @Application VARCHAR(256),
  @DeviceName  VARCHAR(256)
  )
AS
  BEGIN
    SET NOCOUNT ON;

    SELECT LogId,
           DateTime,
           PatientID,
           Application,
           DeviceName,
           Message,
           LocalizedMessage,
           MessageId,
           LogType
    FROM   dbo.LogData
    WHERE  DateTime >= @StartDate AND DateTime <= @EndDate AND ( LogType = @LogType  OR @LogType IS NULL ) AND ( PatientID = @PatientID  OR @PatientID IS NULL ) AND ( DeviceName = @DeviceName  OR @DeviceName IS NULL ) AND ( Application = @Application  OR @Application IS NULL )

  END

