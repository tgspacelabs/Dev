

CREATE PROCEDURE [dbo].[GetLegacyPatientChannelList]
    (
     @patientId UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [channel_type_id] AS [PATIENT_CHANNEL_ID],
        [channel_type_id] AS [CHANNEL_TYPE_ID]
    FROM
        [dbo].[int_patient_channel]
    WHERE
        [patient_id] = @patientId
        AND [active_sw] = 1;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetLegacyPatientChannelList';

