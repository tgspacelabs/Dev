
CREATE PROCEDURE [dbo].[usp_CA_CheckETSession]  
(
@patient_id UNIQUEIDENTIFIER
)
AS
  BEGIN
    SELECT TOP 1 [Sequence] 
    FROM [dbo].[PatientSessionsMap] 
    WHERE [PatientId] = @patient_id;
  END

