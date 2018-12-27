

CREATE PROCEDURE [dbo].[GetPatientAuditLogData]
    (
     @PatientID DPATIENT_ID
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [AuditId],
        [DateTime],
        [PatientID],
        [Application],
        [DeviceName],
        [Message],
        [ItemName],
        [OriginalValue],
        [NewValue],
        [HashedValue],
        [ChangedBy]
    FROM
        [dbo].[AuditLogData]
    WHERE
        [PatientID] = @PatientID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientAuditLogData';

