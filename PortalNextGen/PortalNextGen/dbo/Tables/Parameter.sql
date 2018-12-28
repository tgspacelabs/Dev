CREATE TABLE [dbo].[Parameter] (
    [ParameterID]         INT           IDENTITY (1, 1) NOT NULL,
    [AcquisitionModuleID] INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_Parameter_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Parameter_ParameterID] PRIMARY KEY CLUSTERED ([ParameterID] ASC),
    CONSTRAINT [FK_Parameter_AcquisitionModule_AcquisitionModuleID] FOREIGN KEY ([AcquisitionModuleID]) REFERENCES [dbo].[AcquisitionModule] ([AcquisitionModuleID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Parameter_AcquisitionModule_AcquisitionModuleID]
    ON [dbo].[Parameter]([AcquisitionModuleID] ASC);

