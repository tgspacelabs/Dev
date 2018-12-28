CREATE TABLE [dbo].[InputRate] (
    [InputRateID]     INT           IDENTITY (1, 1) NOT NULL,
    [InputType]       VARCHAR (20)  NOT NULL,
    [PeriodStart]     DATETIME2 (7) NOT NULL,
    [PeriodLength]    INT           NOT NULL,
    [RateCounter]     INT           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_InputRate_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_InputRate_InputRateID] PRIMARY KEY CLUSTERED ([InputRateID] ASC)
);

