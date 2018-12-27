

CREATE PROCEDURE [dbo].[GetAuditLogData]
    (
     @StartDate DATETIME,
     @EndDate DATETIME,
     @ItemName VARCHAR(256),
     @PatientID DPATIENT_ID,
     @Application VARCHAR(256),
     @DeviceName VARCHAR(256)
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
        [DateTime] >= @StartDate
        AND [DateTime] <= @EndDate
        AND ([ItemName] = @ItemName
        OR @ItemName IS NULL
        )
        AND ([PatientID] = @PatientID
        OR @PatientID IS NULL
        )
        AND ([DeviceName] = @DeviceName
        OR @DeviceName IS NULL
        )
        AND ([Application] = @Application
        OR @Application IS NULL
        );
   
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetAuditLogData';

