CREATE TABLE [dbo].[OrganizationShiftSchedule] (
    [OrganizationShiftScheduleID] INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]              INT           NOT NULL,
    [ShiftName]                   NVARCHAR (8)  NOT NULL,
    [ShiftStartDateTime]          DATETIME2 (7) NULL,
    [CreatedDateTime]             DATETIME2 (7) CONSTRAINT [DF_OrganizationShiftSchedule_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_OrganizationShiftSchedule_OrganizationShiftScheduleID] PRIMARY KEY CLUSTERED ([OrganizationShiftScheduleID] ASC),
    CONSTRAINT [FK_OrganizationShiftSchedule_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrganizationShiftSchedule_OrganizationID_ShiftName]
    ON [dbo].[OrganizationShiftSchedule]([OrganizationID] ASC, [ShiftName] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_OrganizationShiftSchedule_Organization_OrganizationID]
    ON [dbo].[OrganizationShiftSchedule]([OrganizationID] ASC);

