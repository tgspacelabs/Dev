﻿CREATE TABLE [dbo].[GeneralAlarmsData] (
    [AlarmId]             UNIQUEIDENTIFIER NOT NULL,
    [StatusTimeout]       TINYINT          NULL,
    [StartDateTime]       DATETIME         NOT NULL,
    [EndDateTime]         DATETIME         NULL,
    [StatusValue]         INT              NOT NULL,
    [PriorityWeightValue] INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId]      UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]          UNIQUEIDENTIFIER NOT NULL,
    [IDEnumValue]         INT              NOT NULL,
    [EnumGroupId]         UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_GeneralAlarmsData_AlarmId] PRIMARY KEY NONCLUSTERED ([AlarmId] ASC)
);


GO
CREATE CLUSTERED INDEX [idxc_GeneralAlarmsData1]
    ON [dbo].[GeneralAlarmsData]([TopicSessionId] ASC, [StartDateTime] ASC, [EndDateTime] ASC, [PriorityWeightValue] ASC, [IDEnumValue] ASC);


GO

CREATE TRIGGER [dbo].[trg_Copy_General_Alarm]
ON [dbo].[GeneralAlarmsData]
FOR INSERT
AS
BEGIN

	INSERT INTO [dbo].[int_print_job_et_alarm]
	(
		[AlarmId]
	   ,[PatientId]
	   ,[TopicSessionId]
	   ,[DeviceSessionId]
	   ,[AlarmStartTimeUTC]
	   ,[AlarmEndTimeUTC]
	   ,[StrTitleLabel]
	   ,[FirstName]
	   ,[LastName]
	   ,[FullName]
	   ,[ID1]
	   ,[ID2]
	   ,[DOB]
	   ,[FacilityName]
	   ,[UnitName]
	   ,[MonitorName]
	   ,[StrMessage]
	   ,[RowLastUpdatedOn]
	)
	SELECT [AlarmId] = inserted.[AlarmId]
	      ,[PatientId] = [LatestPatientAssignment].[PatientId]
		  ,[TopicSessionId] = [TopicSessions].[Id]
		  ,[DeviceSessionId] = [DeviceSessions].[Id]
		  ,[AlarmStartTimeUTC] = inserted.[StartDateTime]
		  ,[AlarmEndTimeUTC] = inserted.[EndDateTime]
		  ,[StrTitleLabel] = [AlarmResources].[Label]
		  ,[FirstName] = [int_person].[first_nm]
		  ,[LastName] = [int_person].[last_nm]
		  ,[FullName] = ISNULL([int_person].[last_nm], '') + ', ' + ISNULL([int_person].[first_nm], '')
		  ,[ID1] = [int_mrn_map].[mrn_xid]
		  ,[ID2] = [int_mrn_map].[mrn_xid2]
		  ,[DOB] = [int_patient].[dob]
		  ,[FacilityName] = [v_DeviceSessionAssignment].[FacilityName]
		  ,[UnitName] = [v_DeviceSessionAssignment].[UnitName]
		  ,[MonitorName] = [v_DeviceSessionAssignment].[MonitorName]
		  ,[StrMessage] = [AlarmResources].[StrMessage]
		  ,[RowLastUpdatedOn] = GETDATE()
		FROM inserted
		INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id]=inserted.[TopicSessionId]
		INNER JOIN [dbo].[DeviceSessions] ON [DeviceSessions].[Id]=[TopicSessions].[DeviceSessionId]
		INNER JOIN
		(
			SELECT [PatientSessionId]
			      ,[PatientId]
				FROM
				(
					SELECT [PatientSessionId]
					      ,[PatientId]
						  ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
						FROM [dbo].[PatientSessionsMap]
				) AS [PatientAssignmentSequence]
				WHERE [R]=1
		) AS [LatestPatientAssignment]
			ON [LatestPatientAssignment].[PatientSessionId]=[TopicSessions].[PatientSessionId]
		LEFT OUTER JOIN [dbo].[int_mrn_map] ON [int_mrn_map].[patient_id]=[LatestPatientAssignment].[PatientId]
		LEFT OUTER JOIN [dbo].[int_patient] ON [int_patient].[patient_id]=[LatestPatientAssignment].[PatientId]
		LEFT OUTER JOIN [dbo].[int_person] ON [int_person].[person_id]=[LatestPatientAssignment].[PatientId]
		INNER JOIN [dbo].[v_DeviceSessionAssignment] ON [v_DeviceSessionAssignment].[DeviceSessionId]=[DeviceSessions].[Id]
		INNER JOIN [dbo].[AlarmResources]
			ON [AlarmResources].[EnumGroupId]=inserted.[EnumGroupId]
			AND [AlarmResources].[IDEnumValue]=inserted.[IDEnumValue]
			AND Locale = 'en'
		WHERE ([inserted].StatusValue & 32 >= 1)
END

GO

CREATE TRIGGER [dbo].[trg_Update_General_Alarm]
ON [dbo].[GeneralAlarmsData]
FOR UPDATE
AS
BEGIN
	UPDATE int_print_job_et_alarm
	SET AlarmEndTimeUTC=[inserted].EndDateTime
		, RowLastUpdatedOn = GETDATE()
	FROM int_print_job_et_alarm
	INNER JOIN inserted ON [int_print_job_et_alarm].AlarmId = [inserted].AlarmId
	WHERE [inserted].EndDateTime IS NOT NULL
END