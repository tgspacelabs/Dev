
CREATE PROCEDURE [dbo].[GetLegacyPatientChannelList] (@patientId UNIQUEIDENTIFIER) 
AS
BEGIN
  SELECT 
    channel_type_id AS PATIENT_CHANNEL_ID,
    channel_type_id AS CHANNEL_TYPE_ID
 FROM 
   dbo.int_patient_channel
 WHERE 
   patient_id = @patientId and
   active_sw = 1
END

