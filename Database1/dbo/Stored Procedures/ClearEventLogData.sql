
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
        DELETE FROM
            [dbo].[LogData]
        WHERE
            [DateTime] < ISNULL(@StartDate, '9999-12-31');
    END;
    ELSE
    BEGIN
        DELETE FROM
            [dbo].[LogData]
        WHERE
            [PatientID] = @PatientID
            AND [DateTime] < ISNULL(@StartDate, '9999-12-31');
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'ClearEventLogData';

