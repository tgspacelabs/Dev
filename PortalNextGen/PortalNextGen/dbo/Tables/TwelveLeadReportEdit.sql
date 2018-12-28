CREATE TABLE [dbo].[TwelveLeadReportEdit] (
    [TwelveLeadReportEditID] INT           IDENTITY (1, 1) NOT NULL,
    [ReportID]               INT           NOT NULL,
    [InsertDateTime]         DATETIME2 (7) NOT NULL,
    [UserID]                 INT           NULL,
    [version_number]         SMALLINT      NULL,
    [patient_name]           VARCHAR (80)  NULL,
    [report_date]            VARCHAR (80)  NULL,
    [report_time]            VARCHAR (80)  NULL,
    [id_number]              VARCHAR (80)  NULL,
    [birthdate]              VARCHAR (80)  NULL,
    [age]                    VARCHAR (80)  NULL,
    [sex]                    VARCHAR (80)  NULL,
    [height]                 VARCHAR (80)  NULL,
    [weight]                 VARCHAR (80)  NULL,
    [ventRate]               INT           NULL,
    [pr_interval]            INT           NULL,
    [qt]                     INT           NULL,
    [qtc]                    INT           NULL,
    [qrsDuration]            INT           NULL,
    [p_axis]                 INT           NULL,
    [qrs_axis]               INT           NULL,
    [t_axis]                 INT           NULL,
    [interpretation]         VARCHAR (MAX) NULL,
    [CreatedDateTime]        DATETIME2 (7) CONSTRAINT [DF_TwelveLeadReportEdit_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TwelveLeadReportEdit_TwelveLeadReportEditID] PRIMARY KEY CLUSTERED ([TwelveLeadReportEditID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TwelveLeadReportEdit_ReportID_InsertDateTime_UserID]
    ON [dbo].[TwelveLeadReportEdit]([ReportID] ASC, [InsertDateTime] ASC, [UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TwelveLeadReportEdit_User_UserID]
    ON [dbo].[TwelveLeadReportEdit]([UserID] ASC);

