CREATE TABLE [dbo].[InsurancePlan] (
    [InsurancePlanID]     INT           IDENTITY (1, 1) NOT NULL,
    [PlanCode]            NVARCHAR (30) NULL,
    [PlanTypeCodeID]      INT           NULL,
    [InsuranceCompanyID]  INT           NULL,
    [AgreementTypeCodeID] INT           NULL,
    [NoticeOfAdmitSwitch] BIT           NOT NULL,
    [PlanXID]             NVARCHAR (20) NULL,
    [PreAdmitCertCodeID]  INT           NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_InsurancePlan_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_InsurancePlan_InsurancePlanID] PRIMARY KEY CLUSTERED ([InsurancePlanID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_InsurancePlan_InsurancePlanID]
    ON [dbo].[InsurancePlan]([InsurancePlanID] ASC);

