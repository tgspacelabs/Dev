CREATE TABLE [dbo].[OrderLine] (
    [OrderLineID]            INT            IDENTITY (1, 1) NOT NULL,
    [OrderID]                INT            NOT NULL,
    [SequenceNumber]         SMALLINT       NOT NULL,
    [PatientID]              INT            NOT NULL,
    [OriginalPatientID]      INT            NULL,
    [StatusCodeID]           INT            NULL,
    [prov_svcCodeID]         INT            NULL,
    [UniversalServiceCodeID] INT            NULL,
    [TransportCodeID]        INT            NULL,
    [OrderLineComment]       NVARCHAR (MAX) NULL,
    [clin_info_comment]      NVARCHAR (MAX) NULL,
    [ReasonComment]          NVARCHAR (MAX) NULL,
    [scheduledDateTime]      DATETIME2 (7)  NULL,
    [observDateTime]         DATETIME2 (7)  NULL,
    [status_chgDateTime]     DATETIME2 (7)  NULL,
    [CreatedDateTime]        DATETIME2 (7)  CONSTRAINT [DF_OrderLine_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_OrderLine_OrderLineID] PRIMARY KEY CLUSTERED ([OrderLineID] ASC),
    CONSTRAINT [FK_OrderLine_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderLine_OrderID_UniversalServiceCodeID_PatientID_SequenceNumber]
    ON [dbo].[OrderLine]([OrderID] ASC, [UniversalServiceCodeID] ASC, [PatientID] ASC, [SequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OrderLine_Order_OrderID]
    ON [dbo].[OrderLine]([OrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OrderLine_Patient_PatientID]
    ON [dbo].[OrderLine]([PatientID] ASC);

