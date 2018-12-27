
CREATE PROCEDURE [dbo].[GetPatientAuditLogData]
  (
  @PatientID DPATIENT_ID
  )
AS
  BEGIN
    SET NOCOUNT ON;

    SELECT AuditId,
           DateTime,
           PatientID,
           Application,
           DeviceName,
           Message,
           ItemName,
           OriginalValue,
           NewValue,
           HashedValue,
           ChangedBy
    FROM   dbo.AuditLogData
    WHERE  PatientID = @PatientID
    

  END


