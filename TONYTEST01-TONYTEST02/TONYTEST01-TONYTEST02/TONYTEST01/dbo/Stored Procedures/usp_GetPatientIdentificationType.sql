

/* Gets the Patient Identification for the ICS Application*/
CREATE PROCEDURE [dbo].[usp_GetPatientIdentificationType]
AS 
BEGIN
	SELECT patient_id_type IdentificationType FROM int_gateway WHERE gateway_type = 'UVN'
END
