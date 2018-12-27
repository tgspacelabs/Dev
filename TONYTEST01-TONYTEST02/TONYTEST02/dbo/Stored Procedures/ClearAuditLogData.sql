
CREATE PROCEDURE [dbo].[ClearAuditLogData]
  @PatientID DPATIENT_ID
AS
  BEGIN
    SET NOCOUNT ON;

    DELETE FROM AuditLogData
    WHERE  PatientID = @patientID

  END


