CREATE TABLE [dbo].[SequentialTest] (
    [ID]           INT              IDENTITY (1, 1) NOT NULL,
    [SequentialID] UNIQUEIDENTIFIER CONSTRAINT [DF_SequentialTest_SequentialID] DEFAULT (newsequentialid()) NOT NULL,
    [Data]         NVARCHAR (50)    NULL,
    CONSTRAINT [PK_SequentialTest] PRIMARY KEY CLUSTERED ([ID] ASC)
);

