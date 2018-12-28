CREATE TABLE [dbo].[OrderMap] (
    [OrderMapID]        INT              IDENTITY (1, 1) NOT NULL,
    [OrderID]           INT              NOT NULL,
    [PatientID]         INT              NOT NULL,
    [OriginalPatientID] INT              NULL,
    [OrganizationID]    INT              NOT NULL,
    [SystemID]          INT              NOT NULL,
    [OrderXID]          UNIQUEIDENTIFIER NOT NULL,
    [TypeCode]          CHAR (1)         NULL,
    [SequenceNumber]    INT              NOT NULL,
    [CreatedDateTime]   DATETIME2 (7)    CONSTRAINT [DF_OrderMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_OrderMap_OrderMapID] PRIMARY KEY CLUSTERED ([OrderMapID] ASC),
    CONSTRAINT [FK_OrderMap_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID]),
    CONSTRAINT [FK_OrderMap_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_OrderMap_OrderID]
    ON [dbo].[OrderMap]([OrderID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderMap_PatientID_OrganizationID_SystemID_OrderXID_TypeCode_SequenceNumber]
    ON [dbo].[OrderMap]([PatientID] ASC, [OrganizationID] ASC, [SystemID] ASC, [OrderXID] ASC, [TypeCode] ASC, [SequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OrderMap_Order_OrderID]
    ON [dbo].[OrderMap]([OrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OrderMap_Organization_OrganizationID]
    ON [dbo].[OrderMap]([OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OrderMap_Patient_PatientID]
    ON [dbo].[OrderMap]([PatientID] ASC);

