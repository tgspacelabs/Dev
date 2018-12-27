create proc [dbo].[usp_GetMonitorList]
(
@filters NVARCHAR(MAX)
)
as
begin
DECLARE @QUERY     NVARCHAR(MAX)
DECLARE @QUERY1     NVARCHAR(MAX)

set @QUERY = 'SELECT [Name] = [v_Monitors].[monitor_name],
       [Network ID] = RTRIM([v_Monitors].[network_id]),
       [Node ID] = [v_Monitors].[node_id],
       [Bed ID] = [v_Monitors].[bed_id],
       [Channel] = RTRIM([v_Monitors].[channel]),
       [Description] = [v_Monitors].[monitor_dsc],
       [Unit] = [FacilityOrg].[organization_cd] + '' - '' + [UnitOrg].[organization_cd],
       [Room] = [v_Monitors].[room],
       [Bed] = RTRIM([v_Monitors].[bed_cd]),
       [Interval] = [UnitOrg].[auto_collect_interval],
       [Last Used] = [dbo].[fnUtcDateTimeToLocalTime](MAX([VitalsData].[TimestampUTC])),
       [Active] = MAX(CASE WHEN [DeviceSessions].[EndTimeUTC] IS NULL THEN ''Y'' ELSE ''N'' END),
       [Subnet] = [v_Monitors].[subnet],
       [monitor_id] = [v_Monitors].[monitor_id],
       [assignment_id] = [v_Monitors].[assignment_cd]
    FROM [dbo].[v_Monitors]
    LEFT OUTER JOIN [dbo].[DeviceSessions] ON [DeviceSessions].[DeviceId] = [v_Monitors].[monitor_id]
    LEFT OUTER JOIN [dbo].[TopicSessions] ON [TopicSessions].[DeviceSessionId] = [DeviceSessions].[Id]
    LEFT OUTER JOIN [dbo].[VitalsData] ON [TopicSessions].[Id] = [VitalsData].[TopicSessionId]
    LEFT OUTER JOIN [dbo].[int_organization] [UnitOrg] ON [UnitOrg].[organization_id] = [v_Monitors].[unit_org_id]
    LEFT OUTER JOIN [dbo].[int_organization] [FacilityOrg] ON [FacilityOrg].[organization_id] = [UnitOrg].[parent_organization_id]'

set @QUERY1 = ' GROUP BY [v_Monitors].[monitor_name],
                         [v_Monitors].[network_id],
                         [v_Monitors].[node_id],
                         [v_Monitors].[bed_id],
                         [v_Monitors].[channel],
                         [v_Monitors].[monitor_dsc],
                         [FacilityOrg].[organization_cd],
                         [UnitOrg].[organization_cd],
                         [v_Monitors].[room],
                         [v_Monitors].[bed_cd],
                         [UnitOrg].[auto_collect_interval],
                         [v_Monitors].[subnet],
                         [v_Monitors].[monitor_id],
                         [v_Monitors].[assignment_cd]
                         
                ORDER BY [Name]'

                if (len(@filters) > 0)
                begin
                            set @QUERY = @QUERY + 'where '
                            set @QUERY = @QUERY + @filters
                            set @QUERY = @QUERY + @QUERY1
                end
                else
                set @QUERY = @QUERY + @QUERY1

                exec(@QUERY)                                                            
end
