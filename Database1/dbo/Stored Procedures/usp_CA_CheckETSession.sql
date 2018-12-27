

CREATE PROCEDURE [dbo].[usp_CA_CheckETSession]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        [Sequence]
    FROM
        [dbo].[PatientSessionsMap]
    WHERE
        [PatientId] = @patient_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CA_CheckETSession';

