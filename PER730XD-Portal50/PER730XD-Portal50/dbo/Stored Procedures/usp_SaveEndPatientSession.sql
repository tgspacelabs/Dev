
CREATE PROCEDURE [dbo].[usp_SaveEndPatientSession]
    (@endPatientSessionData [dbo].[PatientSessionDataType] READONLY)
AS
BEGIN

    SET NOCOUNT ON

    UPDATE [dbo].[PatientSessions]
    SET [EndTimeUTC] = [x].[EndTimeUTC]
    FROM @endPatientSessionData AS [x]
    WHERE [PatientSessions].[Id] = [x].[Id] AND [PatientSessions].[EndTimeUTC] IS NULL

END
