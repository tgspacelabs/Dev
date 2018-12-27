CREATE TABLE [dbo].[int_print_job_et_alarm] (
    [AlarmId]           UNIQUEIDENTIFIER NOT NULL,
    [PatientId]         UNIQUEIDENTIFIER NULL,
    [TopicSessionId]    UNIQUEIDENTIFIER NOT NULL,
    [DeviceSessionId]   UNIQUEIDENTIFIER NOT NULL,
    [AlarmStartTimeUTC] DATETIME         NOT NULL,
    [AlarmEndTimeUTC]   DATETIME         NULL,
    [StrTitleLabel]     NVARCHAR (50)    NULL,
    [FirstName]         NVARCHAR (50)    NULL,
    [LastName]          NVARCHAR (50)    NULL,
    [FullName]          NVARCHAR (150)   NULL,
    [ID1]               NVARCHAR (30)    NULL,
    [ID2]               NVARCHAR (30)    NULL,
    [DOB]               NVARCHAR (40)    NULL,
    [FacilityName]      NVARCHAR (180)   NULL,
    [UnitName]          NVARCHAR (180)   NULL,
    [MonitorName]       NVARCHAR (255)   NOT NULL,
    [StrMessage]        NVARCHAR (120)   NOT NULL,
    [StrLimitFormat]    NVARCHAR (120)   NULL,
    [StrValueFormat]    NVARCHAR (120)   NULL,
    [ViolatingValue]    NVARCHAR (120)   NULL,
    [SettingViolated]   NVARCHAR (120)   NULL,
    [RowLastUpdatedOn]  SMALLDATETIME    NOT NULL,
    [Sequence]          BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_int_print_job_et_alarm_AlarmId] PRIMARY KEY CLUSTERED ([AlarmId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_int_print_job_et_alarm_DeviceSessionId]
    ON [dbo].[int_print_job_et_alarm]([DeviceSessionId] ASC);

