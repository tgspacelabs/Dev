
CREATE PROCEDURE [dbo].[InsertAuditLogData]
  (
  @AuditId       VARCHAR(64),
  @PatientID     VARCHAR(256),
  @Application   VARCHAR(256),
  @DeviceName    VARCHAR(256),
  @Message       VARCHAR(MAX),
  @ItemName      VARCHAR(256),
  @OriginalValue VARCHAR(MAX),
  @NewValue      VARCHAR(MAX),
  @ChangedBy     VARCHAR(64),
  @HashedValue   BINARY(20)
  )
AS
  BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.AuditLogData
                (AuditId,
                 DateTime,
                 PatientID,
                 Application,
                 DeviceName,
                 Message,
                 ItemName,
                 OriginalValue,
                 NewValue,
                 ChangedBy,
                 HashedValue)
    VALUES      (@AuditId,
                 GetDate(),
                 @PatientID,
                 @Application,
                 @DeviceName,
                 @Message,
                 @ItemName,
                 @OriginalValue,
                 @NewValue,
                 @ChangedBy,
                 @HashedValue)
  END

