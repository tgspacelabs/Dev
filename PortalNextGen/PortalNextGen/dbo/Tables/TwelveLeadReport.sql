CREATE TABLE [dbo].[TwelveLeadReport] (
    [ReportID]          INT             NOT NULL,
    [PatientID]         INT             NOT NULL,
    [OriginalPatientID] INT             NULL,
    [MonitorID]         INT             NOT NULL,
    [ReportNumber]      INT             NOT NULL,
    [ReportDateTime]    DATETIME2 (7)   NOT NULL,
    [ExportSwitch]      BIT             NOT NULL,
    [ReportData]        VARBINARY (MAX) NOT NULL,
    [CreatedDateTime]   DATETIME2 (7)   CONSTRAINT [DF_TwelveLeadReport_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TwelveLeadReport_ReportID_PatientID] PRIMARY KEY CLUSTERED ([ReportID] ASC, [PatientID] ASC),
    CONSTRAINT [FK_TwelveLeadReport_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_TwelveLeadReport_reportDateTime]
    ON [dbo].[TwelveLeadReport]([ReportDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TwelveLeadReport_Patient_PatientID]
    ON [dbo].[TwelveLeadReport]([PatientID] ASC);

