CREATE TABLE [dbo].[Address] (
    [AddressID]           INT           IDENTITY (1, 1) NOT NULL,
    [AddressLocationCode] NCHAR (1)     NOT NULL,
    [AddressTypeCode]     NCHAR (1)     NOT NULL,
    [ActiveSwitch]        BIT           NOT NULL,
    [OriginalPatientID]   INT           NULL,
    [Line1Description]    NVARCHAR (80) NULL,
    [Line2Description]    NVARCHAR (80) NULL,
    [Line3Description]    NVARCHAR (80) NULL,
    [City]                NVARCHAR (30) NULL,
    [CountyCodeID]        INT           NULL,
    [StateCode]           NVARCHAR (3)  NULL,
    [CountryCodeID]       INT           NULL,
    [PostalCode]          NVARCHAR (15) NULL,
    [StartDateTime]       DATETIME2 (7) NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_Address_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Address_AddressID_AddressLocationCode_AddressTypeCode]
    ON [dbo].[Address]([AddressID] ASC, [AddressLocationCode] ASC, [AddressTypeCode] ASC);

