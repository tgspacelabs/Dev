CREATE TABLE [dbo].[SystemParameter] (
    [SystemParameterID]    INT            IDENTITY (1, 1) NOT NULL,
    [Name]                 NVARCHAR (30)  NOT NULL,
    [ParameterValue]       NVARCHAR (80)  NOT NULL,
    [ActiveFlag]           BIT            NOT NULL,
    [AfterDischargeSwitch] BIT            NOT NULL,
    [DebugSwitch]          BIT            NOT NULL,
    [Description]          NVARCHAR (255) NOT NULL,
    [CreatedDateTime]      DATETIME2 (7)  CONSTRAINT [DF_SystemParameter_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SystemParameter_SystemParameterID] PRIMARY KEY CLUSTERED ([SystemParameterID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SystemParameter_SystemParameterID]
    ON [dbo].[SystemParameter]([SystemParameterID] ASC);

