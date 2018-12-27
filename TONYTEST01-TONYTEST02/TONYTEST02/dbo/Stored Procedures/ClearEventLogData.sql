
CREATE PROCEDURE [dbo].[ClearEventLogData]
  (
  @PatientID DPATIENT_ID,
  @StartDate DATETIME
  )
AS
  BEGIN
    SET NOCOUNT ON;

    IF @PatientID IS NULL
      BEGIN
        DELETE FROM dbo.LogData
        WHERE  DateTime < IsNull( @StartDate,
                                  '9999-12-31' )
      END
    ELSE
      BEGIN
        DELETE FROM dbo.LogData
        WHERE  PatientID = @PatientID AND DateTime < IsNull( @StartDate,
                                      '9999-12-31' )

      END
  END


