
CREATE PROCEDURE [dbo].[usp_Get_AuditLogDefault]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ISNULL([login_id], N'') AS [Login ID],
        [application_id] AS [Application],
        [device_name] AS [Location],
        [audit_dt] AS [Date],
        [mrn_xid] AS [Patient ID],
        [short_dsc] AS [Event],
        [audit_descr] AS [Description]
    FROM
        [dbo].[int_audit_log]
        LEFT JOIN [dbo].[int_mrn_map] ON [int_audit_log].[patient_id] = [mrn_xid]
        INNER JOIN [dbo].[int_misc_code] ON [code] = [audit_type];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Get_AuditLogDefault';

