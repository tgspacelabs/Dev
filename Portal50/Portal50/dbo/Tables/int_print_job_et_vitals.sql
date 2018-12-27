CREATE TABLE [dbo].[int_print_job_et_vitals] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [PatientId]      UNIQUEIDENTIFIER NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [GDSCode]        VARCHAR (80)     NULL,
    [Name]           NVARCHAR (255)   NOT NULL,
    [Value]          NVARCHAR (255)   NULL,
    [ResultTimeUTC]  DATETIME         NOT NULL,
    CONSTRAINT [PK_int_print_job_et_vitals_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

