CREATE TABLE [dbo].[Result] (
    [ResultID]                        BIGINT         IDENTITY (0, 1) NOT NULL,
    [PatientID]                       INT            NOT NULL,
    [OriginalPatientID]               INT            NULL,
    [ObservationStartDateTime]        DATETIME2 (7)  NOT NULL,
    [OrderID]                         INT            NOT NULL,
    [IsHistory]                       BIT            NOT NULL,
    [MonitorSwitch]                   BIT            NOT NULL,
    [UniversalServiceCodeID]          INT            NOT NULL,
    [TestCodeID]                      INT            NOT NULL,
    [HistorySequence]                 INT            NOT NULL,
    [test_subID]                      NVARCHAR (20)  NOT NULL,
    [OrderLineSequenceNumber]         SMALLINT       NOT NULL,
    [TestResultSequenceNumber]        SMALLINT       NOT NULL,
    [ResultDateTime]                  DATETIME2 (7)  NOT NULL,
    [ValueTypeCode]                   NVARCHAR (10)  NOT NULL,
    [SpecimenID]                      INT            NOT NULL,
    [SourceCodeID]                    INT            NOT NULL,
    [StatusCodeID]                    INT            NOT NULL,
    [LastNormalDateTime]              DATETIME2 (7)  NOT NULL,
    [Probability]                     FLOAT (53)     NOT NULL,
    [ObservationID]                   INT            NOT NULL,
    [PrincipalResultInterpretationID] INT            NOT NULL,
    [AssistantResultInterpretationID] INT            NOT NULL,
    [TechnicianID]                    INT            NOT NULL,
    [TranscriberID]                   INT            NOT NULL,
    [ResultUnitsCodeID]               INT            NOT NULL,
    [ReferenceRangeID]                INT            NOT NULL,
    [AbnormalCode]                    NVARCHAR (10)  NOT NULL,
    [AbnormalNatureCode]              NVARCHAR (10)  NOT NULL,
    [prov_svcCodeID]                  INT            NOT NULL,
    [nsurv_tfr_ind]                   NVARCHAR (10)  NOT NULL,
    [ResultValue]                     NVARCHAR (255) NOT NULL,
    [ResultText]                      NVARCHAR (MAX) NOT NULL,
    [ResultComment]                   NVARCHAR (MAX) NOT NULL,
    [HasHistory]                      TINYINT        NOT NULL,
    [ModifiedDateTime]                DATETIME2 (7)  NOT NULL,
    [ModifiedUserID]                  INT            NOT NULL,
    [CreatedDateTime]                 DATETIME2 (7)  CONSTRAINT [DF_Result_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Result_ResultID] PRIMARY KEY CLUSTERED ([ResultID] ASC),
    CONSTRAINT [FK_Result_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Result_ObservationStartDateTime]
    ON [dbo].[Result]([ObservationStartDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Result_PatientID_TestCodeID_ResultDateTime_ResultDateTime_ResultValue]
    ON [dbo].[Result]([PatientID] ASC, [TestCodeID] ASC, [ResultDateTime] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_Result_PatientID_TestCodeID_ResultDateTime_ResultID]
    ON [dbo].[Result]([PatientID] ASC, [TestCodeID] ASC, [ResultDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Result_Patient_PatientID]
    ON [dbo].[Result]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Result_Order_OrderID]
    ON [dbo].[Result]([OrderID] ASC);

