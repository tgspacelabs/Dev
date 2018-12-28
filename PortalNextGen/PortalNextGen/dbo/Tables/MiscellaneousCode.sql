CREATE TABLE [dbo].[MiscellaneousCode] (
    [MiscellaneousCodeID] INT            IDENTITY (1, 1) NOT NULL,
    [CodeID]              INT            NOT NULL,
    [OrganizationID]      INT            NOT NULL,
    [SystemID]            INT            NOT NULL,
    [CategoryCode]        CHAR (4)       NOT NULL,
    [MethodCode]          NVARCHAR (10)  NOT NULL,
    [Code]                NVARCHAR (80)  NOT NULL,
    [VerificationSwitch]  BIT            NOT NULL,
    [KeystoneCode]        NVARCHAR (80)  NOT NULL,
    [ShortDescription]    NVARCHAR (100) NOT NULL,
    [spc_pcs_code]        CHAR (1)       NOT NULL,
    [CreatedDateTime]     DATETIME2 (7)  CONSTRAINT [DF_MiscellaneousCode_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MiscellaneousCode_MiscellaneousCodeID] PRIMARY KEY CLUSTERED ([MiscellaneousCodeID] ASC),
    CONSTRAINT [FK_MiscellaneousCode_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE NONCLUSTERED INDEX [IX_MiscellaneousCode_ShortDescription_Code_KeystoneCode]
    ON [dbo].[MiscellaneousCode]([ShortDescription] ASC, [Code] ASC, [KeystoneCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MiscellaneousCode_Code_ShortDescription_KeystoneCode]
    ON [dbo].[MiscellaneousCode]([Code] ASC, [ShortDescription] ASC, [KeystoneCode] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MiscellaneousCode_CategoryCode_Code_OrganizationID_SystemID_MethodCode]
    ON [dbo].[MiscellaneousCode]([CategoryCode] ASC, [Code] ASC, [OrganizationID] ASC, [SystemID] ASC, [MethodCode] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MiscellaneousCode_CodeID]
    ON [dbo].[MiscellaneousCode]([CodeID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MiscellaneousCode_SystemID_MethodCode_OrganizationID_CodeID_CategoryCode_Code_ShortDescription]
    ON [dbo].[MiscellaneousCode]([SystemID] ASC, [MethodCode] ASC, [OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_MiscellaneousCode_Organization_OrganizationID]
    ON [dbo].[MiscellaneousCode]([OrganizationID] ASC);

