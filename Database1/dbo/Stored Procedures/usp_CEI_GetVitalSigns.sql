
--NewQueryVitalSigns--GetVitalSigns

CREATE PROCEDURE [dbo].[usp_CEI_GetVitalSigns]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_vital_live].[patient_id],
        [collect_dt],
        [vital_value],
        [mrn_xid],
        [mrn_xid2],
        [first_nm],
        [middle_nm],
        [last_nm],
        [person_id],
        [organization_cd],
        [node_id],
        [monitor_name]
    FROM
        [dbo].[int_vital_live]
        INNER JOIN [dbo].[int_mrn_map] ON [int_vital_live].[patient_id] = [int_mrn_map].[patient_id]
        INNER JOIN [dbo].[int_person] ON [int_vital_live].[patient_id] = [person_id]
        INNER JOIN [dbo].[int_monitor] ON [int_vital_live].[monitor_id] = [int_monitor].[monitor_id]
        INNER JOIN [dbo].[int_patient_monitor] ON [int_vital_live].[patient_id] = [int_patient_monitor].[patient_id]
                                                  AND [active_sw] = 1
        INNER JOIN [dbo].[int_organization] ON [unit_org_id] = [int_organization].[organization_id]
    WHERE
        [merge_cd] = 'C';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CEI_GetVitalSigns';

