CREATE TABLE [dbo].[Environment] (
    [EnvironmentID]   INT            IDENTITY (1, 1) NOT NULL,
    [envwid]          INT            NOT NULL,
    [DisplayName]     NVARCHAR (50)  NOT NULL,
    [Url]             NVARCHAR (200) NULL,
    [SequenceNumber]  INT            NOT NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_Environment_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Environment_EnvironmentID] PRIMARY KEY CLUSTERED ([EnvironmentID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Environment_envwid_SequenceNumber]
    ON [dbo].[Environment]([envwid] ASC, [SequenceNumber] ASC);

