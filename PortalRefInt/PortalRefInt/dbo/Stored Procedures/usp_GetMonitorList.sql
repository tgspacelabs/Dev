CREATE PROCEDURE [dbo].[usp_GetMonitorList]
    (
     @filters NVARCHAR(MAX),
     @Debug BIT = 0
    )
AS
BEGIN
    DECLARE
        @QUERY NVARCHAR(MAX),
        @QUERY1 NVARCHAR(MAX);

    SET @QUERY = N'
        SELECT 
            [vm].[monitor_name] AS [Name],
            RTRIM([vm].[network_id]) AS [Network ID],
            [vm].[node_id] AS [Node ID],
            [vm].[bed_id] AS [Bed ID],
            RTRIM([vm].[channel]) AS [Channel],
            [vm].[monitor_dsc] AS [Description],
            [FacilityOrg].[organization_cd] + N'' - '' + [UnitOrg].[organization_cd] AS [Unit],
            [vm].[room] AS [Room],
            RTRIM([vm].[bed_cd]) AS [Bed],
            [UnitOrg].[auto_collect_interval] AS [Interval],
            MAX([MaxTimeLocal].[LocalDateTime]) AS [Last Used],
            MAX(CASE WHEN [ds].[EndTimeUTC] IS NULL THEN ''Y''
                     ELSE ''N''
                END) AS [Active],
            [vm].[subnet] AS [Subnet],
            [vm].[monitor_id] AS [monitor_id],
            [vm].[assignment_cd] AS [assignment_id]
        FROM [dbo].[v_Monitors] AS [vm]
            LEFT OUTER JOIN [dbo].[DeviceSessions] AS [ds] ON [ds].[DeviceId] = [vm].[monitor_id]
            LEFT OUTER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[DeviceSessionId] = [ds].[Id]
            LEFT OUTER JOIN [dbo].[VitalsData] AS [vd] ON [ts].[Id] = [vd].[TopicSessionId]
            LEFT OUTER JOIN [dbo].[int_organization] AS [UnitOrg] ON [UnitOrg].[organization_id] = [vm].[unit_org_id]
            LEFT OUTER JOIN [dbo].[int_organization] AS [FacilityOrg] ON [FacilityOrg].[organization_id] = [UnitOrg].[parent_organization_id]
            OUTER APPLY (SELECT
                            MAX([vd2].[TimestampUTC])
                         FROM
                            [dbo].[VitalsData] AS [vd2]
                         WHERE
                            [vd2].[TopicSessionId] = [ts].[Id]
                        ) AS [Vitals] ([MaxTimeUTC])
            OUTER APPLY [dbo].[fntUtcDateTimeToLocalTime]([Vitals].[MaxTimeUTC]) AS [MaxTimeLocal] ';

    SET @QUERY1 = N'
        GROUP BY 
            [vm].[monitor_name],
            [vm].[network_id],
            [vm].[node_id],
            [vm].[bed_id],
            [vm].[channel],
            [vm].[monitor_dsc],
            [FacilityOrg].[organization_cd],
            [UnitOrg].[organization_cd],
            [vm].[room],
            [vm].[bed_cd],
            [UnitOrg].[auto_collect_interval],
            [vm].[subnet],
            [vm].[monitor_id],
            [vm].[assignment_cd]
        ORDER BY [Name];';

    IF (LEN(@filters) > 0)
    BEGIN
        SET @QUERY += N' WHERE ';
        SET @QUERY += @filters;
        SET @QUERY += @QUERY1;
    END;
    ELSE
    BEGIN
        SET @QUERY += @QUERY1;
    END
    
    IF (@Debug = 1)
    BEGIN
        PRINT @QUERY;
    END

    EXEC [sys].[sp_executesql] @QUERY;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieve an optionally filtered list of the monitors attached to the ICS System.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetMonitorList';

