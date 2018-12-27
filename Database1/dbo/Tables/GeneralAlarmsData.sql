CREATE TABLE [dbo].[GeneralAlarmsData] (
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
    [Sequence]            BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_GeneralAlarmsData_StartDateTime_Sequence] PRIMARY KEY CLUSTERED ([StartDateTime] ASC, [Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_GeneralAlarmsData_AlarmId]
    ON [dbo].[GeneralAlarmsData]([AlarmId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarmsData_AcqDateTimeUTC_AlarmId_StartDT_PriorityWtValue_WaveformFeedTypeId_TopicSessionId_IDEnumValue_EnumGroupId]
    ON [dbo].[GeneralAlarmsData]([AcquiredDateTimeUTC] ASC)
    INCLUDE([AlarmId], [StartDateTime], [PriorityWeightValue], [WaveformFeedTypeId], [TopicSessionId], [IDEnumValue], [EnumGroupId]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarmsData_EndDateTime_TopicSessionId_StartDateTime_Sequence]
    ON [dbo].[GeneralAlarmsData]([EndDateTime] ASC, [TopicSessionId] ASC)
    INCLUDE([StartDateTime], [Sequence]) WITH (FILLFACTOR = 100);


GO
CREATE TRIGGER [dbo].[trg_Copy_General_Alarm] ON [dbo].[GeneralAlarmsData]
    FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_print_job_et_alarm]
            ([AlarmId],
             [PatientId],
             [TopicSessionId],
             [DeviceSessionId],
             [AlarmStartTimeUTC],
             [AlarmEndTimeUTC],
             [StrTitleLabel],
             [FirstName],
             [LastName],
             [FullName],
             [ID1],
             [ID2],
             [DOB],
             [FacilityName],
             [UnitName],
             [MonitorName],
             [StrMessage],
             [RowLastUpdatedOn]
            )
    SELECT
        [AlarmId] = [Inserted].[AlarmId],
        [PatientId] = [LatestPatientAssignment].[PatientId],
        [TopicSessionId] = [TopicSessions].[Id],
        [DeviceSessionId] = [DeviceSessions].[Id],
        [AlarmStartTimeUTC] = [Inserted].[StartDateTime],
        [AlarmEndTimeUTC] = [Inserted].[EndDateTime],
        [StrTitleLabel] = [AlarmResources].[Label],
        [FirstName] = [int_person].[first_nm],
        [LastName] = [int_person].[last_nm],
        [FullName] = ISNULL([int_person].[last_nm], '') + ', ' + ISNULL([int_person].[first_nm], ''),
        [ID1] = [int_mrn_map].[mrn_xid],
        [ID2] = [int_mrn_map].[mrn_xid2],
        [DOB] = [int_patient].[dob],
        [FacilityName] = [v_DeviceSessionAssignment].[FacilityName],
        [UnitName] = [v_DeviceSessionAssignment].[UnitName],
        [MonitorName] = [v_DeviceSessionAssignment].[MonitorName],
        [StrMessage] = [AlarmResources].[StrMessage],
        [RowLastUpdatedOn] = CAST(GETDATE() AS SMALLDATETIME)
    FROM
        [Inserted]
        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [Inserted].[TopicSessionId]
        INNER JOIN [dbo].[DeviceSessions] ON [DeviceSessions].[Id] = [TopicSessions].[DeviceSessionId]
        INNER JOIN (SELECT
                        [PatientSessionId],
                        [PatientId]
                    FROM
                        (SELECT
                            [PatientSessionId],
                            [PatientId],
                            ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC) AS [RowNumber]
                         FROM
                            [dbo].[PatientSessionsMap]
                        ) AS [PatientAssignmentSequence]
                    WHERE
                        [PatientAssignmentSequence].[RowNumber] = 1
                   ) AS [LatestPatientAssignment] ON [LatestPatientAssignment].[PatientSessionId] = [TopicSessions].[PatientSessionId]
        LEFT OUTER JOIN [dbo].[int_mrn_map] ON [int_mrn_map].[patient_id] = [LatestPatientAssignment].[PatientId]
        LEFT OUTER JOIN [dbo].[int_patient] ON [int_patient].[patient_id] = [LatestPatientAssignment].[PatientId]
        LEFT OUTER JOIN [dbo].[int_person] ON [int_person].[person_id] = [LatestPatientAssignment].[PatientId]
        INNER JOIN [dbo].[v_DeviceSessionAssignment] ON [v_DeviceSessionAssignment].[DeviceSessionId] = [DeviceSessions].[Id]
        INNER JOIN [dbo].[AlarmResources] ON [AlarmResources].[EnumGroupId] = [Inserted].[EnumGroupId]
                                             AND [AlarmResources].[IDEnumValue] = [Inserted].[IDEnumValue]
                                             AND [Locale] = 'en'
    WHERE
        ([Inserted].[StatusValue] & 32 >= 1);
END;

GO

CREATE TRIGGER [dbo].[trg_Update_General_Alarm] ON [dbo].[GeneralAlarmsData]
    FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_print_job_et_alarm]
    SET
        [AlarmEndTimeUTC] = [Inserted].[EndDateTime],
        [RowLastUpdatedOn] = CAST(GETDATE() AS SMALLDATETIME)
    FROM
        [dbo].[int_print_job_et_alarm]
        INNER JOIN [Inserted] ON [int_print_job_et_alarm].[AlarmId] = [Inserted].[AlarmId]
    WHERE
        [Inserted].[EndDateTime] IS NOT NULL;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GeneralAlarmsData';

