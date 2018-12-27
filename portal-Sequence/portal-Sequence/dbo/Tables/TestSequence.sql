CREATE TABLE [dbo].[TestSequence] (
    [TestSequence] INT          IDENTITY (1, 1) NOT NULL,
    [NewValue]     BIGINT       CONSTRAINT [DF_TestSequence_NewValue] DEFAULT (NEXT VALUE FOR [dbo].[SequenceBigInt]) NOT NULL,
    [DummyData]    VARCHAR (50) NULL
);



