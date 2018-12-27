


/* Gets the Patient Identification for the ICS Application*/
CREATE PROCEDURE [dbo].[usp_GetPatientIdentificationType]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [patient_id_type] [IdentificationType]
    FROM
        [dbo].[int_gateway]
    WHERE
        [gateway_type] = 'UVN';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Gets the Patient Identification for the ICS Application.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetPatientIdentificationType';

