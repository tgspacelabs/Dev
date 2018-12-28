CREATE TABLE [dbo].[PatientList] (
    [PatientListID]   INT           IDENTITY (1, 1) NOT NULL,
    [OwnerID]         INT           NOT NULL,
    [TypeCode]        CHAR (3)      NOT NULL,
    [list_name]       NVARCHAR (30) NOT NULL,
    [ServiceCodeID]   INT           NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_PatientList_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientList_PatientListID] PRIMARY KEY CLUSTERED ([PatientListID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientList_PatientList_PatientListID]
    ON [dbo].[PatientList]([PatientListID] ASC);

