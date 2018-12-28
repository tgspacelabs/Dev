CREATE TABLE [dbo].[TwelveLeadReportNew] (
    [PatientID]           INT             NOT NULL,
    [ReportID]            INT             NOT NULL,
    [ReportDateTime]      DATETIME2 (7)   NOT NULL,
    [VersionNumber]       SMALLINT        NOT NULL,
    [PatientName]         NVARCHAR (50)   NOT NULL,
    [IDNumber]            NVARCHAR (20)   NOT NULL,
    [BirthDate]           DATE            NOT NULL,
    [Age]                 NVARCHAR (15)   NOT NULL,
    [Gender]              NCHAR (1)       NOT NULL,
    [Height]              NVARCHAR (15)   NOT NULL,
    [Weight]              NVARCHAR (15)   NOT NULL,
    [VentRate]            INT             NOT NULL,
    [PrInterval]          INT             NOT NULL,
    [Qt]                  INT             NOT NULL,
    [Qtc]                 INT             NOT NULL,
    [QrsDuration]         INT             NOT NULL,
    [PAxis]               INT             NOT NULL,
    [QrsAxis]             INT             NOT NULL,
    [TAxis]               INT             NOT NULL,
    [Interpretation]      NVARCHAR (MAX)  NOT NULL,
    [SampleRate]          INT             NOT NULL,
    [SampleCount]         INT             NOT NULL,
    [NumberOfYPoints]     INT             NOT NULL,
    [Baseline]            INT             NOT NULL,
    [YPointsPerUnit]      INT             NOT NULL,
    [WaveformData]        VARBINARY (MAX) NOT NULL,
    [SendRequest]         SMALLINT        NOT NULL,
    [SendComplete]        SMALLINT        NOT NULL,
    [SendDateTime]        DATETIME2 (7)   NOT NULL,
    [InterpretationEdits] NVARCHAR (MAX)  NOT NULL,
    [UserID]              INT             NOT NULL,
    [CreatedDateTime]     DATETIME2 (7)   CONSTRAINT [DF_TwelveLeadReportNew_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TwelveLeadReportNew_PatientID_ReportID] PRIMARY KEY CLUSTERED ([PatientID] ASC, [ReportID] ASC),
    CONSTRAINT [FK_TwelveLeadReportNew_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_TwelveLeadReportNew_TwelveLeadReport_ReportID_PatientID] FOREIGN KEY ([ReportID], [PatientID]) REFERENCES [dbo].[TwelveLeadReport] ([ReportID], [PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_TwelveLeadReportNew_Patient_PatientID]
    ON [dbo].[TwelveLeadReportNew]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TwelveLeadReportNew_TwelveLeadReport_ReportID_PatientID]
    ON [dbo].[TwelveLeadReportNew]([PatientID] ASC, [ReportID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TwelveLeadReportNew_User_UserID]
    ON [dbo].[TwelveLeadReportNew]([UserID] ASC);

