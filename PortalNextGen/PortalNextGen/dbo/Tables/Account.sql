CREATE TABLE [dbo].[Account] (
    [AccountID]              INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]         INT           NOT NULL,
    [AccountXID]             NVARCHAR (40) NOT NULL,
    [AccountStatusCodeID]    INT           NOT NULL,
    [BadDebtSwitch]          BIT           NOT NULL,
    [TotalPaymentsAmount]    SMALLMONEY    NOT NULL,
    [TotalChargesAmount]     SMALLMONEY    NOT NULL,
    [TotalAdjustmentsAmount] SMALLMONEY    NOT NULL,
    [CurrentBalanceAmount]   SMALLMONEY    NOT NULL,
    [AccountOpenDateTime]    DATETIME2 (7) NOT NULL,
    [AccountCloseDateTime]   DATETIME2 (7) NOT NULL,
    [CreatedDateTime]        DATETIME2 (7) CONSTRAINT [DF_Account_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Account_AccountID] PRIMARY KEY CLUSTERED ([AccountID] ASC),
    CONSTRAINT [FK_Account_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Account_AccountXID]
    ON [dbo].[Account]([AccountXID] ASC, [OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Account_Organization_OrganizationID]
    ON [dbo].[Account]([OrganizationID] ASC);

