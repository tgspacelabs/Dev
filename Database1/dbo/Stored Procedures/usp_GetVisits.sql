
CREATE PROCEDURE [dbo].[usp_GetVisits]
    (
     @PatientID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [admit_dt] AS [Admitted],
        [discharge_dt] AS [Discharged],
        [int_encounter].[account_id] AS 'Account Number',
        (ISNULL([organization_cd], '-') + ' ' + ISNULL([rm], '-') + ' ' + ISNULL([bed], '-')) AS [Location],
        [encounter_xid] AS 'Encounter Number',
        [int_encounter].[encounter_id] AS [GUID]
    FROM
        [dbo].[int_encounter]
        INNER JOIN [dbo].[int_encounter_map] ON [int_encounter].[encounter_id] = [int_encounter_map].[encounter_id]
        INNER JOIN [dbo].[int_organization] ON [unit_org_id] = [int_organization].[organization_id]
    WHERE
        [int_encounter].[patient_id] = @PatientID
    ORDER BY
        1 DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetVisits';

