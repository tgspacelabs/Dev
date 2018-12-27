
CREATE VIEW [dbo].[v_PrintJobs]
AS
SELECT
	[print_job_id] = [PrintJobs].[Id],
	[page_number] = ISNULL([PageNumber].[Value], 1),
	[patient_id] = [DeviceSessions].[Id],
	[orig_patient_id] = NULL,
	[job_net_dt] = [dbo].[fnUtcDateTimeToLocalTime]([PrintRequests].[TimestampUTC]),
	[descr] = ISNULL([Description].[Value], '') + ' ' + ISNULL([PrintDateTime].[Value], '') + CASE WHEN [DataNode].[Value] IS NULL THEN '' ELSE ' (' + [DataNode].[Value] + ')' END,
	[data_node] = [DataNode].[Value],
	[sweep_speed] = [SweepSpeed].[Value],
	[duration] = [Duration].[Value],
	[num_channels] = [NumChannels].[Value],
	[job_type] = 'jt' + ISNULL([RequestTypeEnum].[Name], 'Invalid'),
	[bed] = [MonitorName].[Value],
	[recording_time] = [PrintDateTime].[Value],

	[annotation1] = 
		CASE [RequestTypeEnum].[Name] 
			WHEN 'Undefined' THEN ''
			WHEN 'Manual' THEN ISNULL([v_PatientSessions].[patient_name],'') + ' ' + ISNULL([MonitorName].[Value],'') + ' ' + [PrintDateTime].[Value] + ' ' + ISNULL([A0].[Annotation],'')
			WHEN 'Continuous' THEN ''
			WHEN 'Alarm' THEN ISNULL([v_PatientSessions].[patient_name],'') + ' ' + ISNULL([MonitorName].[Value],'') + ' ' + ISNULL([A0].[Annotation],'')
			WHEN 'AutoAlarm' THEN ISNULL([v_PatientSessions].[patient_name],'') + ' ' + ISNULL([MonitorName].[Value],'') + ' ' + ISNULL([A0].[Annotation],'')
			WHEN 'ST' THEN ''
			WHEN 'Arrhythmia' THEN [A0].[Annotation]
			WHEN 'Bitmap' THEN ''
			WHEN 'PreSelected' THEN ''
			WHEN 'TwelveLead' THEN ''
			WHEN 'AllLeads' THEN ''
			ELSE ''
		END,

	[annotation2] =
		CASE [RequestTypeEnum].[Name]
			WHEN 'Undefined' THEN ''
			WHEN 'Manual' THEN [A1].[Annotation]
			WHEN 'Continuous' THEN ''
			WHEN 'Alarm' THEN [A1].[Annotation]
			WHEN 'AutoAlarm' THEN [A1].[Annotation]
			WHEN 'ST' THEN ''
			WHEN 'Arrhythmia' THEN [A1].[Annotation]
			WHEN 'Bitmap' THEN ''
			WHEN 'PreSelected' THEN ''
			WHEN 'TwelveLead' THEN ''
			WHEN 'AllLeads' THEN ''
			ELSE ''
		END,

	[annotation3] =
		CASE [RequestTypeEnum].[Name]
			WHEN 'Undefined' THEN ''
			WHEN 'Manual' THEN [A2].[Annotation]
			WHEN 'Continuous' THEN ''
			WHEN 'Alarm' THEN [A2].[Annotation]
			WHEN 'AutoAlarm' THEN [A2].[Annotation]
			WHEN 'ST' THEN ''
			WHEN 'Arrhythmia' THEN ''
			WHEN 'Bitmap' THEN ''
			WHEN 'PreSelected' THEN ''
			WHEN 'TwelveLead' THEN ''
			WHEN 'AllLeads' THEN ''
			ELSE ''
		END,

	[annotation4] =
		CASE [RequestTypeEnum].[Name]
			WHEN 'Undefined' THEN ''
			WHEN 'Manual' THEN [A3].[Annotation]
			WHEN 'Continuous' THEN ''
			WHEN 'Alarm' THEN [A3].[Annotation]
			WHEN 'AutoAlarm' THEN [A3].[Annotation]
			WHEN 'ST' THEN ''
			WHEN 'Arrhythmia' THEN ''
			WHEN 'Bitmap' THEN ''
			WHEN 'PreSelected' THEN ''
			WHEN 'TwelveLead' THEN ''
			WHEN 'AllLeads' THEN ''
			ELSE ''
		END,

	[print_bitmap] = NULL,
	[twelve_lead_data] = NULL,
	[end_of_job_sw] = NULL,
	[print_sw] = NULL,
	[printer_name] = NULL,
	[last_printed_dt] = NULL,
	[status_code] = NULL,
	[status_msg] = NULL,
	[start_rec] = NULL,
	[row_dt] = NULL,
	[row_id] = NULL

FROM
	[dbo].[PrintRequests]
	INNER JOIN [dbo].[PrintJobs]      ON [PrintJobs].[Id]      = [PrintRequests].[PrintJobId]
	INNER JOIN [dbo].[TopicSessions]  ON [TopicSessions].[Id]  = [PrintJobs].[TopicSessionId]
	INNER JOIN [dbo].[DeviceSessions] ON [DeviceSessions].[Id] = [TopicSessions].[DeviceSessionId]
	INNER JOIN [dbo].[v_PatientSessions] ON [v_PatientSessions].[patient_id] = [DeviceSessions].[Id]

	INNER JOIN [dbo].[Enums] [RequestTypeEnum] ON [RequestTypeEnum].[GroupId] = [PrintRequests].[RequestTypeEnumId] AND [RequestTypeEnum].[Value] = [PrintRequests].[RequestTypeEnumValue]

	LEFT OUTER JOIN [dbo].[PrintRequestData] [PageNumber] ON [PrintRequests].[Id] = [PageNumber].[PrintRequestId] AND [PageNumber].[Name] = 'PageNumber'
	LEFT OUTER JOIN [dbo].[PrintRequestData] [Duration] ON [PrintRequests].[Id] = [Duration].[PrintRequestId] AND [Duration].[Name] = 'Duration'
	LEFT OUTER JOIN [dbo].[PrintRequestData] [NumChannels] ON [PrintRequests].[Id] = [NumChannels].[PrintRequestId] AND [NumChannels].[Name] = 'NumChannels'
	LEFT OUTER JOIN [dbo].[PrintRequestData] [SweepSpeed] ON [PrintRequests].[Id] = [SweepSpeed].[PrintRequestId] AND [SweepSpeed].[Name] = 'SweepSpeed'
	LEFT OUTER JOIN [dbo].[PrintRequestData] [PrintDateTime] ON [PrintRequests].[Id] = [PrintDateTime].[PrintRequestId] AND [PrintDateTime].[Name]='PrintDateTime'
	LEFT OUTER JOIN [dbo].[PrintRequestData] [DataNode] ON [PrintRequests].[Id] = [DataNode].[PrintRequestId] AND [DataNode].[Name]='DataNode'
	LEFT OUTER JOIN [dbo].[PrintRequestData] [MonitorName] ON [PrintRequests].[Id] = [MonitorName].[PrintRequestId] AND [MonitorName].[Name]='MonitorName'
	LEFT OUTER JOIN [dbo].[WaveformAnnotationData] [A0] ON [PrintRequests].[Id] = [A0].[PrintRequestId] AND [A0].[ChannelIndex]=0
	LEFT OUTER JOIN [dbo].[WaveformAnnotationData] [A1] ON [PrintRequests].[Id] = [A1].[PrintRequestId] AND [A1].[ChannelIndex]=1
	LEFT OUTER JOIN [dbo].[WaveformAnnotationData] [A2] ON [PrintRequests].[Id] = [A2].[PrintRequestId] AND [A2].[ChannelIndex]=2
	LEFT OUTER JOIN [dbo].[WaveformAnnotationData] [A3] ON [PrintRequests].[Id] = [A3].[PrintRequestId] AND [A3].[ChannelIndex]=3
	LEFT OUTER JOIN [dbo].[PrintRequestDescriptions] [Description] ON
		[Description].[RequestTypeEnumId] = [PrintRequests].[RequestTypeEnumId] AND
		[Description].[RequestTypeEnumValue] = [PrintRequests].[RequestTypeEnumValue]
