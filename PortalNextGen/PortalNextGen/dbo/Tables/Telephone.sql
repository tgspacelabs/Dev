CREATE TABLE [dbo].[Telephone] (
    [TelephoneID]       INT           IDENTITY (1, 1) NOT NULL,
    [PhoneID]           INT           NOT NULL,
    [PhoneLocationCode] CHAR (1)      NOT NULL,
    [PhoneTypeCode]     CHAR (1)      NOT NULL,
    [SequenceNumber]    INT           NOT NULL,
    [OriginalPatientID] INT           NULL,
    [ActiveSwitch]      BIT           NOT NULL,
    [TelephoneNumber]   NVARCHAR (40) NULL,
    [ExtensionNumber]   NVARCHAR (12) NULL,
    [AreaCode]          NVARCHAR (3)  NULL,
    [mpi_tel1]          SMALLINT      NULL,
    [mpi_tel2]          SMALLINT      NULL,
    [mpi_tel3]          SMALLINT      NULL,
    [StartDateTime]     DATETIME2 (7) NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_Telephone_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Telephone_TelephoneID] PRIMARY KEY CLUSTERED ([TelephoneID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Telephone_PhoneID_PhoneLocationCode_PhoneTypeCode_SequenceNumber]
    ON [dbo].[Telephone]([PhoneID] ASC, [PhoneLocationCode] ASC, [PhoneTypeCode] ASC, [SequenceNumber] ASC);

